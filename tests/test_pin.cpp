#include <gtest/gtest.h>

#include "Pin.hpp"
#include "stm32_gpio_mock.hpp"

class PinTest : public ::testing::Test {
protected:
    void SetUp() override { gpio_mock_reset(); }
};

TEST_F(PinTest, EnablesPortClockOnConstruction) {
    Pin led(5, 'B');
    (void)led;
    EXPECT_EQ(mock_rcc.AHB1ENR & (1u << 1), 1u << 1);
}

TEST_F(PinTest, ConfiguresGeneralOutputMode) {
    Pin pin(7, 'B');
    pin.output(MODE_OUTPUT::GENERAL, TYPE_OUTPUT::PUSH_PULL, SPEED_OUTPUT::LOW);

    const uint32_t bit_low = 7u * 2u;
    const uint32_t bit_high = bit_low + 1u;
    EXPECT_EQ(mock_gpiob.MODER & (1u << bit_low), 1u << bit_low);
    EXPECT_EQ(mock_gpiob.MODER & (1u << bit_high), 0u);
    EXPECT_EQ(mock_gpiob.OTYPER & (1u << 7), 0u);
}

TEST_F(PinTest, SetAndResetUseBsrr) {
    Pin pin(3, 'A');
    pin.output();

    pin.set();
    EXPECT_EQ(mock_gpioa.BSRR & (1u << 3), 1u << 3);

    pin.reset();
    EXPECT_EQ(mock_gpioa.BSRR & (1u << (3u + 16u)), 1u << (3u + 16u));
}

TEST_F(PinTest, ChangeTogglesFromResetToSet) {
    Pin pin(0, 'C');
    pin.output();
    mock_gpioc.IDR = 0;

    pin.change();
    EXPECT_EQ(mock_gpioc.BSRR & 1u, 1u);

    mock_gpioc.IDR = 1u;
    pin.change();
    EXPECT_EQ(mock_gpioc.BSRR & (1u << 16), 1u << 16);
}

TEST_F(PinTest, PullUpConfiguresPupdr) {
    Pin pin(4, 'D', PULL_PIN::PULL_UP);
    (void)pin;

    const uint32_t bit_low = 8u;
    const uint32_t bit_high = 9u;
    EXPECT_EQ(mock_gpiod.PUPDR & (1u << bit_low), 1u << bit_low);
    EXPECT_EQ(mock_gpiod.PUPDR & (1u << bit_high), 0u);
}

TEST_F(PinTest, InputClearsModerBits) {
    Pin pin(2, 'E');
    mock_gpioe.MODER = 0xFFFFFFFFu;

    pin.input();
    EXPECT_EQ(mock_gpioe.MODER & (0x3u << 4), 0u);
}

TEST_F(PinTest, ValueReadsIdr) {
    Pin pin(1, 'F');
    mock_gpiof.IDR = (1u << 1);
    EXPECT_TRUE(pin.value());

    mock_gpiof.IDR = 0;
    EXPECT_FALSE(pin.value());
}

#include "stm32_gpio_mock.hpp"

RCC_TypeDef mock_rcc{};
GPIO_TypeDef mock_gpioa{};
GPIO_TypeDef mock_gpiob{};
GPIO_TypeDef mock_gpioc{};
GPIO_TypeDef mock_gpiod{};
GPIO_TypeDef mock_gpioe{};
GPIO_TypeDef mock_gpiof{};
GPIO_TypeDef mock_gpiog{};
GPIO_TypeDef mock_gpioh{};

void gpio_mock_reset() {
    mock_rcc = {};
    mock_gpioa = {};
    mock_gpiob = {};
    mock_gpioc = {};
    mock_gpiod = {};
    mock_gpioe = {};
    mock_gpiof = {};
    mock_gpiog = {};
    mock_gpioh = {};
}

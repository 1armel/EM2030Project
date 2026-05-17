#pragma once

#include <cstdint>

#ifndef __IO
#define __IO volatile
#endif

typedef struct {
    __IO uint32_t MODER;
    __IO uint32_t OTYPER;
    __IO uint32_t OSPEEDR;
    __IO uint32_t PUPDR;
    __IO uint32_t IDR;
    __IO uint32_t ODR;
    __IO uint32_t BSRR;
    __IO uint32_t LCKR;
    __IO uint32_t AFR[2];
} GPIO_TypeDef;

/* AHB1ENR is at offset 0x30 in RCC_TypeDef */
typedef struct {
    __IO uint32_t _pad0[12];
    __IO uint32_t AHB1ENR;
} RCC_TypeDef;

extern RCC_TypeDef mock_rcc;
extern GPIO_TypeDef mock_gpioa;
extern GPIO_TypeDef mock_gpiob;
extern GPIO_TypeDef mock_gpioc;
extern GPIO_TypeDef mock_gpiod;
extern GPIO_TypeDef mock_gpioe;
extern GPIO_TypeDef mock_gpiof;
extern GPIO_TypeDef mock_gpiog;
extern GPIO_TypeDef mock_gpioh;

#define RCC (&mock_rcc)
#define GPIOA (&mock_gpioa)
#define GPIOB (&mock_gpiob)
#define GPIOC (&mock_gpioc)
#define GPIOD (&mock_gpiod)
#define GPIOE (&mock_gpioe)
#define GPIOF (&mock_gpiof)
#define GPIOG (&mock_gpiog)
#define GPIOH (&mock_gpioh)

void gpio_mock_reset();

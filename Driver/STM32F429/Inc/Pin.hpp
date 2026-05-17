#pragma once

#include <cstdint>

#ifdef HOST_UNIT_TEST
#include "main_host.h"
#else
#include "main.h"
#endif

#define gpio_A_en 1<<0  
#define gpio_B_en 1<<1 
#define gpio_C_en 1<<2 
#define gpio_D_en 1<<3 
#define gpio_E_en 1<<4 
#define gpio_F_en 1<<5 
#define gpio_G_en 1<<6 
#define gpio_H_en 1<<7 

enum class MODE_OUTPUT: char
{
  GENERAL,
  ALTERNATE,
  ANALOG
};

enum class TYPE_OUTPUT:bool
{
  PUSH_PULL,
  OPEN_DRAIN 
};

enum class SPEED_OUTPUT:char
{
  LOW,
  MEDIUM,
  FAST,
  HIGH
};
enum class PULL_PIN: char
{
  NO_PULL,
  PULL_UP,
  PULL_DOWN
};

enum class ALTERNATE_FUNCTION:char
{
  AF0,// system
  AF1,// tim1_2
  AF2,
  AF3,
  AF4,
  AF5,
  AF6,
  AF7,
  AF8,
  AF9,
  AF10,
  AF11,
  AF12,
  AF13,
  AF14,
  AF15
};

class Pin
{
private:
    uint16_t num_;
    uint8_t port_;
    uint16_t bit_high;
    uint16_t bit_low;
		GPIO_TypeDef * PORT;
		GPIO_TypeDef * GPIO(uint8_t u8Port);
public:
    Pin(uint16_t num, uint8_t port, PULL_PIN type_pull = PULL_PIN::NO_PULL);
		void input();
    void alternate(ALTERNATE_FUNCTION af);
		void output(MODE_OUTPUT mode = MODE_OUTPUT::GENERAL, TYPE_OUTPUT type_output = TYPE_OUTPUT::PUSH_PULL, SPEED_OUTPUT speed_output = SPEED_OUTPUT::LOW);
    bool value();
    void set();
    void reset();
    void change();
		void pull(PULL_PIN pull);


    //void lock();
    ~Pin();
};



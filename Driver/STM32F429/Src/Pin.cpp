#include "Pin.hpp"
//47GDR-KB5H2-JML9J-S1SFD-MMFGX-TXRF4
Pin::Pin(uint16_t num, uint8_t port, PULL_PIN type_pull):num_(num), port_(port)
{
	PORT = GPIO(port_);
	bit_low = num_*2;
	bit_high = bit_low+1;

	switch (type_pull)
	{
	case PULL_PIN::NO_PULL:
		PORT->PUPDR &= ~(1<<bit_low);
		PORT->PUPDR &= ~(1<<bit_high);
		break;
	case PULL_PIN::PULL_DOWN:
		PORT->PUPDR &= ~(1<<bit_low);
		PORT->PUPDR |=   1<<bit_high;
		break;
	case PULL_PIN::PULL_UP:
		PORT->PUPDR |=   1<<bit_low;
		PORT->PUPDR &= ~(1<<bit_high);
		break;
	default:
		break;
	}
}

void Pin::pull(PULL_PIN pull){
	
	switch (pull)
	{
		case PULL_PIN::NO_PULL:
				PORT->PUPDR &= ~(1<<bit_low);
				PORT->PUPDR &= ~(1<<bit_high);
				break;
		case PULL_PIN::PULL_DOWN:
				 PORT->PUPDR &= ~(1<<bit_low);
				 PORT->PUPDR |=   1<<bit_high;
				 break;
		case PULL_PIN::PULL_UP:
				 PORT->PUPDR |=   1<<bit_low;
				 PORT->PUPDR &= ~(1<<bit_high);
				 break;
		default:
			break;
	}
	
}


GPIO_TypeDef * Pin::GPIO(uint8_t u8Port){
	switch(u8Port){
		
		case 'A':
				RCC->AHB1ENR |= gpio_A_en;
				return GPIOA;
		
		case 'B':
				RCC->AHB1ENR |= gpio_B_en;
				return GPIOB;
		
		case 'C':
				RCC->AHB1ENR |= gpio_C_en;
				return GPIOC;
		
		case 'D':
				RCC->AHB1ENR |= gpio_D_en;
				return GPIOD;
		
		case 'E':
				RCC->AHB1ENR |= gpio_E_en;
				return GPIOE;
		
		case 'F':
				RCC->AHB1ENR |= gpio_F_en;
				return GPIOF;
		
		case 'G':
				RCC->AHB1ENR |= gpio_G_en;
				return GPIOG;
		
		case 'H':
				RCC->AHB1ENR |= gpio_G_en;
				return GPIOH;
		
		default:
			return nullptr;
		
	}

}

void Pin::input(){
	PORT->MODER &= ~((1<<bit_low)| (1<<bit_high));	
}

void Pin::output(MODE_OUTPUT mode, TYPE_OUTPUT type_output, SPEED_OUTPUT speed_output ){

	switch (mode)
	{
	case MODE_OUTPUT::ALTERNATE:
		PORT->MODER |= 1<<bit_high;
  		PORT->MODER &= ~(1<<bit_low);
		break;

	case MODE_OUTPUT::GENERAL:
		PORT->MODER &= ~(1<<bit_high);
  		PORT->MODER |= 1<<bit_low;
		break;

	case MODE_OUTPUT::ANALOG:
		PORT->MODER |= 1<<bit_high;
  		PORT->MODER |= 1<<bit_low;
		break;
	
	default:
		break;
	}

	if(type_output == TYPE_OUTPUT ::PUSH_PULL){
		PORT->OTYPER &= ~(1<<num_);
	}else{
		PORT->OTYPER |= 1<<num_;
	}


	switch (speed_output)
	{
	case SPEED_OUTPUT::LOW:
		PORT->OSPEEDR &= ~(1<<bit_high);
  		PORT->OSPEEDR &= ~(1<<bit_low);
		break;

	case SPEED_OUTPUT::MEDIUM:
			PORT->OSPEEDR &= ~(1<<bit_high);
  		PORT->OSPEEDR |= 1<<bit_low;
		break;

	case SPEED_OUTPUT::FAST:
		PORT->OSPEEDR |= 1<<bit_high;
  		PORT->OSPEEDR &= ~(1<<bit_low);
		break;
	
	case SPEED_OUTPUT::HIGH:
		PORT->OSPEEDR |= 1<<bit_high;
  		PORT->OSPEEDR |= 1<<bit_low;
		break;
	
	default:
		break;
	}
	
}
bool Pin::value(){
	return (PORT->IDR & (1<< num_)) >> num_;
}

void Pin::set(){
	//PORT->ODR |= (1 << num_);
	PORT->BSRR |= 1 << num_;
	
}
void Pin::reset(){
	//PORT->ODR &= ~(1 << num_);
	PORT->BSRR |= 1 << (num_ + 16);
}

void Pin::change(void)
{
	if(value())
	{
		reset();
	}else
	{
		set();
	}
}

void Pin::alternate(ALTERNATE_FUNCTION af){
	uint16_t bit_start;
	uint16_t bit_1;
	uint16_t bit_2;
	uint16_t bit_3;
	//__IO uint32_t * PORT_temp;
	if(num_<8){
		bit_start = num_ * 4;
		//PORT_temp = &(PORT->AFR[1]);
	}else{
		bit_start = (num_ - 8) * 4;		
		//PORT_temp = (uint32_t *)(PORT->AFR) + 1;
	}
	bit_1 = bit_start + 1;
	bit_2 = bit_1 + 1;
	bit_3 = bit_2 + 1;
	switch (af)
	{
	case ALTERNATE_FUNCTION::AF0 :
		if(num_<8){
			PORT->AFR[0] &= ~(1<< bit_start) ; 
			PORT->AFR[0] &= ~(1<< bit_1) ; 
			PORT->AFR[0] &= ~(1<< bit_2) ; 
			PORT->AFR[0] &= ~(1<< bit_3) ; 
		}else{
			PORT->AFR[1] &= ~(1<< bit_start) ; 
			PORT->AFR[1] &= ~(1<< bit_1) ; 
			PORT->AFR[1] &= ~(1<< bit_2) ; 
			PORT->AFR[1] &= ~(1<< bit_3) ; 
		}

		break;
		case ALTERNATE_FUNCTION::AF1 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF2 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF3 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF4 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF5 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF6 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF7 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] &= ~(1<< bit_3) ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] &= ~(1<< bit_3) ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF8 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF9 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF10 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF11 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] &= ~(1<< bit_2) ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] &= ~(1<< bit_2) ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF12 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF13 :
			if(num_<8){
				PORT->AFR[0] |=   1<< bit_start ; 
				PORT->AFR[0] &= ~(1<< bit_1) ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] |=   1<< bit_start ; 
				PORT->AFR[1] &= ~(1<< bit_1) ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF14 :
			if(num_<8){
				PORT->AFR[0] &= ~(1<< bit_start) ; 
				PORT->AFR[0] |=   1<< bit_1 ; 
				PORT->AFR[0] |=   1<< bit_2 ; 
				PORT->AFR[0] |=   1<< bit_3 ; 
			}else{
				PORT->AFR[1] &= ~(1<< bit_start) ; 
				PORT->AFR[1] |=   1<< bit_1 ; 
				PORT->AFR[1] |=   1<< bit_2 ; 
				PORT->AFR[1] |=   1<< bit_3 ; 
			}
		break;
		case ALTERNATE_FUNCTION::AF15 :
			if(num_<8){
				PORT->AFR[0] |=  1<< bit_start ; 
				PORT->AFR[0] |=  1<< bit_1 ; 
				PORT->AFR[0] |=  1<< bit_2 ; 
				PORT->AFR[0] |=  1<< bit_3 ; 
			}else{
				PORT->AFR[1] |=  1<< bit_start ; 
				PORT->AFR[1] |=  1<< bit_1 ; 
				PORT->AFR[1] |=  1<< bit_2 ; 
				PORT->AFR[1] |=  1<< bit_3 ; 
			}
				// *PORT_temp &= ~(1<< bit_start) ; 
				// *PORT_temp &= ~(1<< bit_1) ; 
				// *PORT_temp &= ~(1<< bit_2) ; 
				// *PORT_temp &= ~(1<< bit_3) ; 
		break;
	
	default:
		break;
	}

}
Pin::~Pin()
{
	/*switch(port_){
		
		case 'A':
				RCC->AHB1ENR &= ~(1<<0);
				break;		
		case 'B':
				RCC->AHB1ENR &= ~(1<<1);
				break;		
		case 'C':
				RCC->AHB1ENR &= ~(1<<2);
				break;		
		case 'D':
				RCC->AHB1ENR &= ~(1<<3);
				break;		
		case 'E':
				RCC->AHB1ENR &= ~(1<<4);
				break;		
		case 'F':
				RCC->AHB1ENR &= ~(1<<5);
				break;		
		case 'G':
				RCC->AHB1ENR &= ~(1<<6);
				break;		
		case 'H':
				RCC->AHB1ENR &= ~(1<<7);
				break;		
		default:
		break;
		
	}*/
}
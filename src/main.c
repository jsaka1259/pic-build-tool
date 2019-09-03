#include <xc.h>
#include <stdint.h>

// CONFIG1
#pragma config FOSC = INTOSC    // Oscillator Selection (INTOSC oscillator: I/O function on CLKIN pin)
#pragma config WDTE = OFF       // Watchdog Timer Enable (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable (PWRT disabled)
#pragma config MCLRE = OFF      // MCLR Pin Function Select (MCLR/VPP pin function is digital input)
#pragma config CP = OFF         // Flash Program Memory Code Protection (Program memory code protection is disabled)
#pragma config CPD = OFF        // Data Memory Code Protection (Data memory code protection is disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable (Brown-out Reset disabled)
#pragma config CLKOUTEN = OFF   // Clock Out Enable (CLKOUT function is disabled. I/O or oscillator function on the CLKOUT pin)
#pragma config IESO = OFF       // Internal/External Switchover (Internal/External Switchover mode is disabled)
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor is disabled)

// CONFIG2
#pragma config WRT = OFF        // Flash Memory Self-Write Protection (Write protection off)
#pragma config PLLEN = OFF      // PLL Enable (4x PLL disabled)
#pragma config STVREN = OFF     // Stack Overflow/Underflow Reset Enable (Stack Overflow or Underflow will not cause a Reset)
#pragma config BORV = LO        // Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), low trip point selected.)
#pragma config LVP = OFF        // Low-Voltage Programming Enable (High-voltage on MCLR/VPP must be used for programming)

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 4000000      // Oscillator Frequency 4MHz
#endif

void delay_ms(uint16_t num)
{
  uint16_t lc;
  for (lc = 0 ; lc < num ; lc++)
    __delay_ms(1);
}

void main()
{
  OSCCON = 0b01101010;          // INTOSC: 4MHz
  ANSELA = 0b00000000;          // Analog: All Disable
  TRISA  = 0b00001000;          // I/O: All OUT
  PORTA  = 0b00000000;          // Port: All LOW
  while(1) {
    RA0 = ~RA0;                 // Pin No.7(RA0): TOGGLE
    delay_ms(1000);           // Wait 1.0 sec
  }
}

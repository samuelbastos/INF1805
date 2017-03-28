#include "helloworld.h"

unsigned long timer;
int pastValue[2];

/* Funções de registro: */
void button_listen (int pin) 
{
  pinMode(pin, INPUT);
}

void timer_set (int ms) 
{
 timer = ms;
}

/* Programa principal: */
void setup ()
{
 init(); // inicialização do usuário
 pastValue[0] = 0;
 pastValue[1] = 0;
}

void loop () 
{
 int i;
 
 int one = digitalRead(BUT_PIN1);
 int two = digitalRead(BUT_PIN2);
  
 if(pastValue[0] != one) 
 {
  button_changed(BUT_PIN1, one);
  pastValue[0] = one;
 }
 if(pastValue[1] != two)
 {
  button_changed(BUT_PIN2, two);
  pastValue[1] = two;
 }

}

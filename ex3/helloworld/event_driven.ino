#include "helloworld.h"

unsigned long timer;

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
}

void loop () 
{
 int one = digitalRead(BUT_PIN1);
 int two = digitalRead(BUT_PIN2);

 if(lastClicked == BUT_PIN1) digitalWrite(LED_PIN, two);
 else digitalWrite(LED_PIN, one);
 
 if(!one)
 {
  if(lastClicked == BUT_PIN2) 
  {
    button_changed(BUT_PIN1, BUT_PIN2);
    digitalWrite(LED_PIN, one);
  }
  lastClicked = BUT_PIN1;
 }
 if(!two)
 {
  if(lastClicked == BUT_PIN1) 
  {
    button_changed(BUT_PIN2, BUT_PIN1);
    digitalWrite(LED_PIN, two);
  }
  lastClicked = BUT_PIN2;
 }
}

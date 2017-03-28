#include "tarefa2.h"

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

  unsigned long actual = millis();
  unsigned long dif = actual - time;  
  unsigned limitDif;
  
  if(dif >= limit)
  {
    time = actual;
    
    if(even) digitalWrite(LED_PIN, HIGH);
   
    else digitalWrite(LED_PIN, LOW);  
 
    even = !even;
  }
  
 if(!one)
 {
  if(lastClicked == BUT_PIN2) 
  {
    button_changed(BUT_PIN1, BUT_PIN2);
  }
  lastClicked = BUT_PIN1;
 }
 if(!two)
 {
  if(lastClicked == BUT_PIN1) 
  {
    button_changed(BUT_PIN2, BUT_PIN1);
  }
  lastClicked = BUT_PIN2;
 }
}

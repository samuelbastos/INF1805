#include "tarefa2.h"

unsigned long timer;
int oneFlag;
int twoFlag;

/* Funções de registro: */
void button_listen (int pin) 
{
  pinMode(pin, INPUT);
}

void timer_set (int flag, int ms) 
{
  if(flag == LED_PIN)
    timer = ms;
  else if(flag == BUT_PIN1)
    timeOne = ms;
  else
    timeTwo = ms;
  
}

/* Programa principal: */
void setup ()
{
  init_listener(); // inicialização do usuário
  oneFlag = 1;
  twoFlag = 1;
}

void loop () 
{
  unsigned long actual = millis();
  unsigned long dif = actual - timer;  
  unsigned limitDif;
  
  if(dif >= limit)
  {
    timer_set(LED_PIN, actual);
    timer_expired();
  }
 
  int one = digitalRead(BUT_PIN1);
  int two = digitalRead(BUT_PIN2);

  if(!one) timer_set(BUT_PIN1, millis());
  if(!two) timer_set(BUT_PIN2, millis());
  beenPressed = timeOne || timeTwo;
  butTimeDif = abs(timeOne - timeTwo);  
  
  if(one && !oneFlag) 
  {
    button_changed(BUT_PIN1);
    oneFlag = one;
  }
  if(two && !twoFlag) 
  {
    button_changed(BUT_PIN2);
    twoFlag = two;
  }
  
  twoFlag = two;
  oneFlag = one;
}

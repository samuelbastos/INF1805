#include "tarefa2.h"

unsigned long timer;
int pastValue[2];
unsigned long timeOne;
unsigned long timeTwo;
int oneFlag;
int twoFlag;
unsigned long limit;
bool even;

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
  init_listener(); // inicialização do usuário
  pastValue[0] = 0;
  pastValue[1] = 0;
  timeOne = 0;
  timeTwo = 0;
  oneFlag = 1;
  twoFlag = 1;
  limit = 1000;
  even = true;
}

void loop () 
{
  unsigned long actual = millis();
  unsigned long dif = actual - timer;  
  unsigned limitDif;
  
  if(dif >= limit)
  {
    timer_set(actual);
    timer_expired();
    
    if(even) digitalWrite(LED_PIN, HIGH);
   
    else digitalWrite(LED_PIN, LOW);  
 
    even = !even;
  }
 
  int one = digitalRead(BUT_PIN1);
  int two = digitalRead(BUT_PIN2);

  if(!one) timeOne = millis(); 
  if(!two) timeTwo = millis();
  bool beenPressed = timeOne || timeTwo;
  unsigned long butTimeDif = abs(timeOne - timeTwo);
  
  if(beenPressed && butTimeDif  <= 500)
  {
    digitalWrite(LED_PIN, HIGH);
    while(1);
  }
  
  if(one && !oneFlag) limit += 100;
  if(two && !twoFlag) limit -= 100;

  oneFlag = one;
  twoFlag = two;

}

#include "event_driven.h"
#include "tarefa2.h"

void button_changed(int pin)
{
  if(pin == BUT_PIN1)
  {
    if(beenPressed && butTimeDif  <= 500)
    {
      digitalWrite(LED_PIN, HIGH);
      while(1);
    }

    limit += 100;
  }
  else
  {
    if(beenPressed && butTimeDif  <= 500)
    {
      digitalWrite(LED_PIN, HIGH);
      while(1);
    }

    limit -= 100;
  }
}

void timer_expired(void)
{
  Serial.println("Time expired");
  digitalWrite(LED_PIN, even);
  even = !even;
}

void init_listener(void)
{
  Serial.begin(9600);
  
  button_listen(BUT_PIN1);
  button_listen(BUT_PIN2);

  pinMode(LED_PIN, OUTPUT);

  unsigned long init_time = millis();
  timer_set(LED_PIN, init_time);
  limit = 1000;
  even = 0;
  timeOne = 0;
  timeTwo = 0;
}


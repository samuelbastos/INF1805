#include "event_driven.h"
#include "tarefa2.h"

void button_changed(int pin, int v)
{
  Serial.print("Button: ");
  Serial.print(pin);
  Serial.print("New button: ");
  Serial.println(v);
}

void timer_expired(void)
{
  Serial.println("Time expired");
}

void init_listener(void)
{
  Serial.begin(9600);
  
  button_listen(BUT_PIN1);
  button_listen(BUT_PIN2);

  pinMode(LED_PIN, OUTPUT);

  unsigned long init_time = millis();
  timer_set(init_time);
}


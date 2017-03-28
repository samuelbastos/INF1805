#include "event_driven.h"
#include "tarefa2.h"

int lastClicked;

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

void init(void)
{
  Serial.begin(9600);
  
  button_listen(BUT_PIN1);
  button_listen(BUT_PIN2);

  lastClicked = 99;
  pinMode(LED_PIN, OUTPUT);
  
  timer_set(1000);
}


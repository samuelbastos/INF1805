#include "event_driven.h"
#include "helloworld.h"

void button_changed(int pin, int v)
{
  Serial.print("Button: ");
  Serial.print(pin);
  Serial.print("New button: ");
  Serial.println(v);

  digitalWrite(LED_PIN, v);
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

  pinMode(LED_PIN, OUTPUT);
}


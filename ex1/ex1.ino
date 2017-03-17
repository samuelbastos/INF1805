#define LED_PIN 10
#define BUT_PIN A2
 
unsigned long time;
unsigned long limit = 1000;
bool even;
 
void setup()
{
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUT_PIN, INPUT);
  time = millis();
  even = true;
}
 
void loop()
{  
  unsigned long actual = millis();
  unsigned long dif = actual - time;  
 
  if( dif >= limit )
  {
    time = actual;
    
    if(even) digitalWrite(LED_PIN, HIGH);
   
    else digitalWrite(LED_PIN, LOW);  
 
    even = !even;
  }
 
  int but = digitalRead(BUT_PIN);
  if(!but)
  {
    digitalWrite(LED_PIN, LOW);
    while(1);
  }
}

#define LED_PIN 10
#define BUT_PIN1 A1
#define BUT_PIN2 A2
 
unsigned long time;
unsigned long timeOne;
unsigned long timeTwo;
int oneFlag;
int twoFlag;
unsigned long limit;
bool even;
 
void setup()
{
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUT_PIN1, INPUT);
  pinMode(BUT_PIN2, INPUT);
  time = millis();
  timeOne = 0;
  timeTwo = 0;
  oneFlag = 1;
  twoFlag = 1;
  limit = 1000;
  even = true;
}
 
void loop()
{  
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

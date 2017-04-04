#include "meArm.h"
#include <Servo.h>
#include "nunchuck.h"

meArm arm;
Nunchuck  nunchuck;
bool clawState = false;

void setup() 
{
  Serial.begin(9600);
  arm.begin(6, 9, 5, 3);
  nunchuck.begin(NUNCHUCK_PLAYER_1);
  nunchuck.joy_set_scaled_min_max(0, 99, 0 ,99);
}

void loop() 
{
  nunchuck.update();

  float dx = 0;
  float dy = 0;
  float dz = 0;
  float dg = 0;
  
  if (nunchuck.joy_left())
    dx = -5.0;
  else if (nunchuck.joy_right())
    dx = 5.0;

  if (nunchuck.joy_up())
  {
    dy = 5.0;
    dz = -5.0;
  }
  else if (nunchuck.joy_down())
  {
    dy = -5.0;
    dz = 5.0;
  }
    
  if (nunchuck.button_z())
  {
    if(clawState)  arm.openGripper();
    else arm.closeGripper();
    
    clawState = !clawState;
  }
    
  if (nunchuck.button_c()) {
    arm.gotoPoint(0, 100, 50);
  } 
  
  
  if (!(dx == 0 && dy == 0))
    arm.goDirectlyTo(arm.getX() + dx, arm.getY() + dy, arm.getZ() + dz);
  
  delay(50);
  
}

const int joy_sw = 18;
const int joy_x = 15;
const int joy_y = 2;
const int button = 13;
const int bswitch = 19;

int xpos = 0;
int oldxpos = 0;
int ypos = 0;
int oldypos = 0;
int mapX = 0;
int mapY = 0;
int sw_state = 1;
int oldSwState = 0;
int buttonState = 1;
int oldButtonState = 0;
int bswitchState = 1;
int oldbswitchState = 0;

void printConditions(){
    mapX = map(xpos, 0, 1023, -512, 512);
    mapY = map(ypos, 0, 1023, -512, 512);
    Serial.print(buttonState);
    Serial.print(" "); 
    Serial.print(sw_state); 
    Serial.print(" "); 
    Serial.print(mapX);
    Serial.print(" ");
    Serial.print(mapY);
    Serial.print(" ");
    Serial.print(bswitchState);
    Serial.print("\n");   
}
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(joy_x, INPUT);
  pinMode(joy_y, INPUT);
  pinMode(joy_sw, INPUT_PULLUP);
  pinMode(button, INPUT_PULLUP);
  pinMode(bswitch, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(button);
  xpos = analogRead(joy_x);
  ypos = analogRead(joy_y);
  sw_state = digitalRead(joy_sw);
  bswitchState = digitalRead(bswitch);
  if(buttonState != oldButtonState || sw_state != oldSwState || oldxpos != xpos || oldypos != ypos || oldbswitchState != bswitchState){
    printConditions();
    oldButtonState = buttonState;
    sw_state = oldSwState;
    oldxpos = xpos;
    oldypos = ypos;
    oldbswitchState = bswitchState;
  }

  delay(100);

}

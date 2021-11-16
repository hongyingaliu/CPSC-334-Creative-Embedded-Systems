//Includes the Arduino Stepper Library
//#include <Stepper.h>
#include <ESP32Servo.h>

Servo myservo;
Servo myservotwo;
int pos = 0;
int turn = 0;
int servoPin = 13;
int servoPin_two = 16;
int bswitch = 33;
int switchState = 1;
int x = 10;
int y = 0;
int a = 4;
int counter = 0;
// Defines the number of steps per rotation
//const int stepsPerRevolution = 2048;

// Creates an instance of stepper class
// Pins entered in sequence IN1-IN3-IN2-IN4 for proper step sequence
//Stepper myStepper = Stepper(stepsPerRevolution, 19, 5, 18, 17);

int red_light_pin= 25;
int green_light_pin = 27;
int blue_light_pin = 26;

void setup() {
  // put your setup code here, to run once:
  //myStepper.setSpeed(4);
  ledcAttachPin(red_light_pin, 9);
  ledcAttachPin(green_light_pin, 10);
  ledcAttachPin(blue_light_pin, 11);
  ledcSetup(9, 1000, 8);
  ledcSetup(10, 1000, 8);
  ledcSetup(11, 1000, 8);
  Serial.begin(9600);

  pinMode(bswitch, INPUT_PULLUP);

  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  myservo.setPeriodHertz(50);    // standard 50 hz servo
  myservo.attach(servoPin, 500, 2400); 
  myservotwo.setPeriodHertz(50); 
  myservotwo.attach(servoPin_two, 500, 2600);
  //RGB_color(0, 255, 0);
}

void loop() {
  // put your main code here, to run repeatedly:
  switchState = digitalRead(bswitch);
  Serial.println(switchState);
  if (switchState == 0) {
    change_color(counter);
    counter++;
    //RGB_color(255, 255, 0);
    // Rotate CW 
    /*counter = counter + a;
    if (counter >= 2048){ 
      a = -4;
    } else if (counter == 0) {
      a = 4;     
    }
    myStepper.step(a);*/
  
    //for (int i = 0; i <= 2; i += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      myservo.write(pos);    // tell servo to go to position in variable 'pos'
      delay(10);             // waits 15ms for the servo to reach the position
    //}    

    //for (int i = 0; i <= 1; i += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      myservotwo.write(turn);    // tell servo to go to position in variable 'pos'
      delay(40);             // waits 15ms for the servo to reach the position
    //} 
    pos = pos + x;
    turn = turn + y;

    if (pos == 60) {
      x = -1;
    } else if (pos == 10) {
      x = 1;
    }

    if (turn == 180) {
      y = -1;
    } else if (turn == 0) {
      y = 1;
    }  
    
  //continue;
  }
  
  if (switchState == 1) {
    RGB_color(0, 0, 0);
  }
  
  //RGB_color(255, 0, 0);
}

void change_color(int i){
  if (i == 0) {
    RGB_color(255, 0, 0); // Red
  } else if (i == 10){
    RGB_color(255, 255, 0); // Yellow
  } else if (i == 20){
    RGB_color(0, 255, 0); // Green
  } else if (i == 30){
    RGB_color(0, 255, 255); // Cyan
  } else if (i == 40){
    RGB_color(0, 0, 255); // Blue
  } else if (i == 50){
    RGB_color(255, 0, 255); // Magenta
    counter = 0;
  }
}

void RGB_color(int red_light_value, int green_light_value, int blue_light_value){
  ledcWrite(9, red_light_value);
  ledcWrite(10, green_light_value);
  ledcWrite(11, blue_light_value);
}

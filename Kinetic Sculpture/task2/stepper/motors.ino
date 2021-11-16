//Includes the Arduino Stepper Library
#include <Stepper.h>
#include <ESP32Servo.h>

Servo myservo;
int pos = 0;
int servoPin = 13;
int bswitch = 33;
int switchState = 1;
int x = 10;
int a = 4;
int counter = 0;
// Defines the number of steps per rotation
const int stepsPerRevolution = 2048;

// Creates an instance of stepper class
// Pins entered in sequence IN1-IN3-IN2-IN4 for proper step sequence
Stepper myStepper = Stepper(stepsPerRevolution, 19, 5, 18, 17);

void setup() {
  // put your setup code here, to run once:
  myStepper.setSpeed(4);
  Serial.begin(9600);

  pinMode(bswitch, INPUT_PULLUP);

  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  myservo.setPeriodHertz(50);    // standard 50 hz servo
  myservo.attach(servoPin, 500, 2400); 
}

void loop() {
  // put your main code here, to run repeatedly:
  switchState = digitalRead(bswitch);
  Serial.println(switchState);
  if (switchState == 0) {
    // Rotate CW 

    counter = counter + a;
    if (counter >= 2048){ 
      a = -4;
    } else if (counter == 0) {
      a = 4;     
    }
    myStepper.step(a);
  
    for (int i = 0; i <= 2; i += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      myservo.write(pos);    // tell servo to go to position in variable 'pos'
      delay(5);             // waits 15ms for the servo to reach the position
    }    

    pos = pos + x;

    if (pos == 90) {
      x = -2;
    } else if (pos == 0) {
      x = 2;
    }
    /*myStepper.step(stepsPerRevolution);
   // Serial.println("CW");

    if (pos == 0) {
      for (pos = 0; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
        // in steps of 1 degree
        myservo.write(pos);    // tell servo to go to position in variable 'pos'
        delay(7);             // waits 15ms for the servo to reach the position
      }
    } else if (pos = 180) {
      for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);    // tell servo to go to position in variable 'pos'
        delay(7); 
      } 
    }*/
  }
}

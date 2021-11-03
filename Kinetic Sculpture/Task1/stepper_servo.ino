//Includes the Arduino Stepper Library
#include <Stepper.h>
//Custom ESP32 Servo library because Arduino does not have one
#include <ESP32Servo.h>

//create servo object
Servo myservo;
//position counter
int pos = 0;
//servo GPIO pin number
int servoPin = 13;

// Defines the number of steps per rotation, full revolution is 2048 for our servos
const int stepsPerRevolution = 2048;

// Creates an instance of stepper class
// Pins entered in sequence IN1-IN3-IN2-IN4 for proper step sequence
Stepper myStepper = Stepper(stepsPerRevolution, 19, 5, 18, 17);

void setup() {
  // Nothing to do (Stepper Library sets pins as outputs)
  myStepper.setSpeed(10);
  Serial.begin(9600);

    // put your setup code here, to run once:
  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  myservo.setPeriodHertz(50);    // standard 50 hz servo
  //adjusts rotation range of servo
  myservo.attach(servoPin, 500, 2500); 
}

void loop() {
  // Rotate CW 
  myStepper.step(stepsPerRevolution);
  Serial.println("CW");
  delay(1000);

  // put your main code here, to run repeatedly:
  for (int i = 0; i <= 10; i += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    myservo.write(pos);    // tell servo to go to position in variable 'pos'
    delay(15);             // waits 15ms for the servo to reach the position
  }

  pos = pos + 10;
  
  //if the servo has reached 180 return to the original starting position
  if (pos == 180) {
    pos = 0;
    myservo.write(pos);    
    delay(15);
  } 
  
  // Rotate CCW
  /*myStepper.step(-stepsPerRevolution);
  Serial.println("CCW");
  delay(1000);*/
}

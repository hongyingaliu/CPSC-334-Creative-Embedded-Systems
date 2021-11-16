//const int servoPin = 13;
const int servoPin = 16;
int dutyCycle = 3;


const int PWMFreq = 50;
const int PWMChannel = 0;
const int PWMResolution = 8;
int dir = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  ledcSetup(PWMChannel, PWMFreq, PWMResolution);
  ledcAttachPin(servoPin, PWMChannel);
  ledcWrite(PWMChannel, dutyCycle);
}

void loop() {
  // put your main code here, to run repeatedly:
  /*for(dutyCycle = 6; dutyCycle <= 12; dutyCycle++)
  {
    ledcWrite(PWMChannel, dutyCycle);
    delay(70);    
  }
  for(dutyCycle = 12; dutyCycle >= 6; dutyCycle--)
  {
    ledcWrite(PWMChannel, dutyCycle);
    delay(70);    
  }*/
  Serial.println(dutyCycle);
  delay(10);
  moveservo(dutyCycle, dir);
  if (dutyCycle >= 32) {
    dir = 1;
  } else if (dutyCycle <= 3) {
    dir = 0;
  }
}

void moveservo(int a, int b){
  if (b == 0) {
    ledcWrite(PWMChannel, dutyCycle+1);
    delay(70);    
    dutyCycle = dutyCycle++;
  } else if (b == 1) {

    ledcWrite(PWMChannel, dutyCycle-1);
    delay(70);    
    dutyCycle = dutyCycle--;    
  }
}

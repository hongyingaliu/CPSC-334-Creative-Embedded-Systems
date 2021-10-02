const int buttonPin = 4;
int buttonState = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(buttonPin);
  //Serial.println(buttonState);
  if(buttonState == LOW){
    Serial.println("pushed");
  } //else {
    //Serial.println(buttonState);
  //}
}

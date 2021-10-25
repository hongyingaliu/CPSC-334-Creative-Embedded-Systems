const int piezo_pin = 33;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

}

void loop() {
  // put your main code here, to run repeatedly:
  int piezo_state = analogRead(piezo_pin);
  Serial.println(piezo_state);
  float piezoV = piezo_state / 1023.0 * 5.0;
  //Serial.println(piezoV);
  delay(15);
}

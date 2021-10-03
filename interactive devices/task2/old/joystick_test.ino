const int joy_sw = 18;
const int joy_x = 15;
const int joy_y = 2;

int xpos = 0;
int ypos = 0;
int sw_state = 0;
int mapX = 0;
int mapY = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(joy_x, INPUT);
  pinMode(joy_y, INPUT);
  pinMode(joy_sw, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  xpos = analogRead(joy_x);
  ypos = analogRead(joy_y);
  sw_state = digitalRead(joy_sw);
  mapX = map(xpos, 0, 1023, -512, 512);
  mapY = map(ypos, 0, 1023, -512, 512);

  Serial.print("X: ");
  Serial.print(mapX);
  Serial.print(" | Y: ");
  Serial.print(mapY);
  Serial.print(" | Button: ");
  Serial.println(sw_state);

  delay(100);
}

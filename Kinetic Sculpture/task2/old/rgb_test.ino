int red_light_pin= 25;
int green_light_pin = 26;
int blue_light_pin = 27;
void setup() {
  ledcAttachPin(red_light_pin, 0);
  ledcAttachPin(green_light_pin, 1);
  ledcAttachPin(blue_light_pin, 2);
  ledcSetup(0, 2000, 8);
  ledcSetup(1, 2000, 8);
  ledcSetup(2, 2000, 8);
}
void loop() {
  RGB_color(255, 0, 0); // Red
  delay(1000);
  RGB_color(0, 255, 0); // Green
  delay(1000);
  RGB_color(0, 0, 255); // Blue
  delay(1000);
  RGB_color(255, 255, 125); // Raspberry
  delay(1000);
  RGB_color(0, 255, 255); // Cyan
  delay(1000);
  RGB_color(255, 0, 255); // Magenta
  delay(1000);
  RGB_color(255, 255, 0); // Yellow
  delay(1000);
  RGB_color(255, 255, 255); // White
  delay(1000);
}
void RGB_color(int red_light_value, int green_light_value, int blue_light_value)
 {
  ledcWrite(0, red_light_value);
  ledcWrite(1, green_light_value);
  ledcWrite(2, blue_light_value);
}

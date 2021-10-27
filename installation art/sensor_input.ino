// capacitive sensing includes
#include <CapacitiveSensor.h>
#include <WiFi.h>

const char* ssid = "yale wireless";
const char* password = "";
const uint16_t port = 8090;
const char* host = "172.29.21.84";

const int lightPinOne = 35;
const int lightPinTwo = 34;
const int lightPinThree = 32;
const int lightPinFour = 33;
const int piezo_pin = 39;
CapacitiveSensor sensor = CapacitiveSensor(18,19);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(10);

  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
  }

  Serial.println("ESP32 connected!");
  Serial.println(WiFi.localIP());
}

void loop() {
  // put your main code here, to run repeatedly:
  WiFiClient client;
  int light_one = analogRead(lightPinOne);
  int light_two = analogRead(lightPinTwo);
  int light_three = analogRead(lightPinThree);
  int light_four = analogRead(lightPinFour);
  int piezo_state = analogRead(piezo_pin);
  long touch =  sensor.capacitiveSensor(30);  
  if (!client.connect(host, port)) {
      Serial.println("connection failed");
      return;
  }

  client.print(String(light_one) + " " + String(light_two) + " " + String(light_three) + " " + String(light_four) + " " +String(piezo_state) + " " + String(touch));
  //client.print(light_two);
  //Serial.println(light_val);
  delay(5);
  
}

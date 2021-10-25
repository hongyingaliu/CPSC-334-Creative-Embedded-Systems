#include <WiFi.h>

const char* ssid = "yale wireless";
const char* password = "";
const uint16_t port = 8090;
const char* host = "172.29.21.84";

const int sensorPin = 35;
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
  int light_val = analogRead(sensorPin);

  if (!client.connect(host, port)) {
      Serial.println("connection failed");
      return;
  }

  client.print(light_val);
  Serial.println(light_val);
  delay(10);
  
}

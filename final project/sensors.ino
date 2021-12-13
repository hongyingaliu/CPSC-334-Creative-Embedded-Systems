const int lightPin = 34;
const int buttonPin = 4;
const int buttontwoPin = 17;
int buttonState = 0;
const int piezo_pin = 33;

int prev = 0;
int prev2 = 0;
int push = 0;
int push2 = 0;
int lmin = 3000;
int pmax = 0;
int flag = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  delay(10);
}

void loop() {
  // put your main code here, to run repeatedly:
  int piezo_state = analogRead(piezo_pin); //
  int light_val = analogRead(lightPin);
  buttonState = digitalRead(buttonPin);
  int buttontwoState = digitalRead(buttontwoPin);

  checkforpush(buttonState);
  checkforreset(buttontwoState);
  lightmin(light_val);
  piezomax(piezo_state);
  

  String data = String(flag) + ',' + String(push) + ',' + String(lmin) + ',' + String(pmax) + ',';
  if(flag == 0 && push2 == 1){
    Serial.println(data);
    push2 = 0;
    flag = 1;
  }

//reset
  if(flag == 1 && push2 == 1){
    //Serial.println("here");
    Serial.println(data);   
    push2 = 0;
    push = 0;
    lmin = 3000;
    pmax = 0;
    flag = 0;
    delay(50);
  }
  
  //String data = String(buttontwoState) + ',' + String(piezo_state) + ',' + String(light_val) + ',' + String(buttonState);
  //Serial.println(data);
  delay(20);
}

void checkforpush(int i){
  if (prev == 0 && i ==1){
    push ++;
  }
  prev = i;
}

void lightmin(int i){
  if (lmin > i) {
    lmin = i;
  } 
}

void piezomax(int i){
  if (pmax < i) {
    pmax = i;
  } 
}

void checkforreset(int i){
  if (prev2 == 0 && i == 1){
    push2 = 1;
  } 
  prev2 = i; 
}

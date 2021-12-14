const int lightPin = 34;
const int lighttwoPin = 35;
const int buttonPin = 4;
const int buttontwoPin = 17;
int buttonState = 0;
const int piezo_pin = 33;

int prev = 0;
int prev2 = 0;
int push = 0;
int push2 = 0;
int lmin = 3000;
int lmin2 = 5000;
int lmax2 = 0;
int ldiff = 0;
int pmax = 0;
int flag = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  delay(10);
  pinMode(buttontwoPin, INPUT_PULLDOWN);
}

void loop() {
  // put your main code here, to run repeatedly:
  int piezo_state = analogRead(piezo_pin); //
  int light_val = analogRead(lightPin);
  int lighttwo_val = analogRead(lighttwoPin);
  buttonState = digitalRead(buttonPin);
  int buttontwoState = digitalRead(buttontwoPin);

  checkforpush(buttonState);

  //push2 += push2;
  if(buttontwoState == 1){
    push2++;
  }
  //checkforreset(buttontwoState);  
  //Serial.println(push2);
  lightmin(light_val);
  piezomax(piezo_state);
  lightdiff(lighttwo_val);
  

  String data = String(flag) + ',' + String(push) + ',' + String(lmin) + ',' + String(pmax) + ',' + String(ldiff) + ',';
  //if(flag == 0 && push2 > 3){
  if(flag == 0 && buttontwoState == 1 && prev2 == 0){
    Serial.println(data);
    push2 = 0;
    prev2 = 1;
    flag = 1;
  }

//reset
  //if(flag == 1 && push2 > 3){
  if(flag == 1 && buttontwoState == 1 && prev2 == 0){
    //Serial.println("here");
    Serial.println(data);   
    push2 = 0;
    prev2 = 1;    
    push = 0;
    lmin = 3000;
    ldiff = 0;
    lmin2 = 5000;
    lmax2 = 0;
    pmax = 0;
    flag = 0;
    delay(40);
  }
  
  //String data = String(buttontwoState) + ',' + String(piezo_state) + ',' + String(light_val) + ',' + String(buttonState);
  //Serial.println(data);
  prev2 = buttontwoState;
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

void lightdiff(int i){
  if(lmin2 > i) {
    lmin2 = i;
  }
  if(lmax2 < i) {
    lmax2 = i;
  }
  ldiff = abs(lmax2 - lmin2);
}
/*void checkforreset(int i){
  if (prev2 == 0 && i == 1){
    push2 = 1;
  } 
  prev2 = i; 
}*/


/*boolean checkforreset(int i){
  if (prev2 == 0 && push2 > 3){
    push2 = 0;
    return true;
  } else {
    return false;  
  }
  prev2 = i;
}*/
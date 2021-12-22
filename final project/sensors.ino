//Add GPIO pins for each sensor
const int lightPin = 34;
const int lighttwoPin = 35;
const int buttonPin = 4;
const int buttontwoPin = 17;
int buttonState = 0;
const int piezo_pin = 33;

//variables used to set limits for sensory data
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
  //read input
  int piezo_state = analogRead(piezo_pin); //
  int light_val = analogRead(lightPin);
  int lighttwo_val = analogRead(lighttwoPin);
  buttonState = digitalRead(buttonPin);
  int buttontwoState = digitalRead(buttontwoPin);

  //check if continue/reset button has been pushed
  checkforpush(buttonState);

  //push2 += push2;
  if(buttontwoState == 1){
    push2++;
  }
  //check to see if the limits have be rewritten
  lightmin(light_val);
  piezomax(piezo_state);
  lightdiff(lighttwo_val);
  
  //compile data that needs to be send to Processing
  String data = String(flag) + ',' + String(push) + ',' + String(lmin) + ',' + String(pmax) + ',' + String(ldiff) + ',';
  //continue
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
  
  prev2 = buttontwoState;
  delay(20);
}

//helps eliminate multiple triggers, must be a new push
void checkforpush(int i){
  if (prev == 0 && i ==1){
    push ++;
  }
  prev = i;
}

//check minimum of light sensor
void lightmin(int i){
  if (lmin > i) {
    lmin = i;
  } 
}

//check for max piezo touch
void piezomax(int i){
  if (pmax < i) {
    pmax = i;
  } 
}

//check for difference in light sensing extremes
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

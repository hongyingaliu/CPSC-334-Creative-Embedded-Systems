import http.requests.*;
import processing.serial.*;

//Built off of Processing example: https://processing.org/examples/noisewave.html


float yoff = 0.0;
int numofWaves = 20;
int intensity = 300;
int h = 0;
int s = 0;
int b = 0;

//float[] xoffs = new float[numofWaves];
Serial myPort;
String val;
int flag;

int reset = 1;    
int piezo = 1;
int light = 1;
int light2 = 1;
int button = 1;
int prev = 0;
int col = 0;

void setup() {
  size(450, 450);
  colorMode(HSB, 360, 100, 100, 1.0);
  
  String portName = "/dev/cu.SLAB_USBtoUART";
  myPort = new Serial(this, portName, 9600);
  
  GetRequest get = new GetRequest("https://rws-cards-api.herokuapp.com/api/v1/cards/random?n=1");
  get.send();
  println(get.getContent());
}

void draw() {
  background(0, 0, 100);
  frameRate(20);
  if(myPort.available() > 0){
    val = myPort.readStringUntil('\n');
  }

  //println(val);
  /*String[] datalist = split(val, ',');
  int reset = int(datalist[0]);    
  int piezo = int(datalist[1]);
  int light = int(datalist[2]);
  int button = int(datalist[3]);
  println(datalist);*/   
  if(val != null && val.length() >= 7){
    String[] datalist = split(val, ',');
    reset = int(datalist[0]); 
    button = int(datalist[1]);    
    light = int(datalist[2]);
    piezo = int(datalist[3]);
    light2 = int(datalist[4]);
    println(datalist);
    //println(piezo);
  }  
  if(flag == 0){
    //println("here");
    textSize(20);
    fill(0);
    textAlign(CENTER);
    text("Touch/press (or don't :] ) around the box!", width/2, height/2);
    text("Press the red button", width/2, height/2 + 20);
    text("when you're ready to move on.", width/2, height/2 + 40);
    
    col = int(random(360));
    if(val != null && reset == 1) {flag = 1;}
    
  } else if(flag == 1){
    
    //println(button);
    numofWaves = button + 1;
    //println(piezo);
    int newinten = int(map(piezo, 0, 4095, 50, 500));
    intensity = newinten;
    //color
    h = col;  //based on light 2
    int col_inc = int(map(light2, 0, 2000, 5, 360));
    //int col_inc = light2;
    int sat = int(map(light, 0, 1000, 100, 0));
    //println(sat);
    s = sat;  //based on light 1
    
    int bright = int(map(light2, 0, 2000, 50, 100));
    b = bright;  //based on light 1 & 2
    int s_inc = int(map(light2, 0, 3000, 5, 45));
    println(s_inc);
    //fill(0);
    float xoff = 0.0;
    //int col = 200;
    int level = 20;
    
    for(int i = 0; i < numofWaves; i++) {
      fill(h,s,b);
      drawWave(xoff, level, intensity);
      xoff += 0.5;
      //col += 70;
      h = (h + col_inc) % 360;
      s = abs(s - s_inc); //% 100;
      level += height/numofWaves - 10;
      //noiseSeed(0);
      //drawWave(1, 200, 100);
    }
    
    if (reset == 0 && prev == 1) {
      flag = 0;
    } else {
      prev = reset;
    }
  }
  
}

void drawWave(float xoff, int level, int intensity) {
  beginShape();
  
  for (float x = 0; x <= width; x +=10) {
    float y = map(noise(xoff, yoff), 0, 1, level, level + intensity);
    
    vertex(x, y);
    
    xoff += 0.05;
  }
  
  yoff += 0.01;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}


class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count){
    imageCount = count;
    images = new PImage[imageCount];
    
    
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + str(i) + ".gif";
      images[i] = loadImage(filename);
      //print(filename);
    }
  }
  
  
  void display(float xpos, float ypos) {
      frame = (frame+1) % imageCount;
      image(images[frame], xpos, ypos, 250,250);
  }
  
  void stop(float xpos, float ypos) {
      PImage stopped = loadImage("birb_landing/8.gif");
      image(stopped, xpos, ypos, 250, 250);
  }
  
  int getWidth() {
    return 250;
  }
}

class Bird {
  float xpos;
  float ypos;
  float randomX;
  float randomY;
  float prevx;
  float prevy;
  float dx;
  float dy;
  float exponent = 5;
  float pct = 0.0;
  float step = 0.01;
  int previndex;
  int flag = 0;
  int lasttime = 0;
  int currenttime;
  int a;
  Animation animation1;
  Animation animation2;
  Animation animation3;
  Animation animation4;
  
  Bird(){
    //setup create it's own first point
    /*float[] start = new float[3];
    start = genPoint(randomX, randomY, previndex);
    randomX = start[0];
    randomY = start[1];
    previndex = int(start[2]);*/
    genPoint();
    prevx = randomX;
    prevy = randomY;
    xpos = prevx;
    ypos = prevy;
    genPoint();  
    animation1 = new Animation("birb/", 8);
    animation2 = new Animation("birb_flipped/", 8);
    animation3 = new Animation("birb_landing/", 14);
    animation4 = new Animation("birb_landing_flipped/", 9);  
  }
  
  void genPoint() {
//  randomX = random(width);
//  randomY = random(height-100);
    int index = int(random(0, numofbranches));
    if(index == previndex) {
      if(index != numofbranches) {
        index = index + 1;
      } else {
        index = index - 1;
      }
    }
    
    previndex = index;
    randomX = xbranches.get(index) + random(50, 200);
    randomY = ybranches.get(index) - 100;
    //print("new point");
}
  
  void update() {
    //print("here");
    dx = randomX - prevx;
    dy = randomY - prevy;
    pct += step;
    
    if (pct < 1.0) {
      xpos = prevx + (pct * dx);
      ypos = prevy + (pow(pct, exponent) * dy);
    } 
    
    if (pct > 0.94) {
      //PImage stopped = loadImage("birb_landing/8.gif");
      //image(stopped, 500, 500);
      if (pct < 0.99) {
        flag = 2;
        if(dx > 0){
           print("in");
           animation3.display(xpos-animation1.getWidth()/2, ypos);
        } else {
           print("in");
           animation4.display(xpos-animation1.getWidth()/2, ypos);
        } 
      } else {
        if (flag == 2) {
          flag = 1;
          animation1.stop(xpos-animation1.getWidth()/2, ypos);
          lasttime = millis();
          //currenttime = millis();
          return;
        }
        
        if (flag == 1) {
           //delay(2000);
           if(millis()-lasttime < 3000){
             animation1.stop(xpos-animation1.getWidth()/2, ypos);
           } else {
             flag = 0;
           }
        } else {
        
        /*if((dx > 0)) {
          animation1.display(xpos-animation1.getWidth()/2, ypos);
        } else {
           animation2.display(xpos-animation1.getWidth()/2, ypos);
        }*/
          prevx = randomX;
          prevy = randomY;
          a = 0;
        //choose new point
          //print(pct + "/n");
          genPoint();
          pct = 0.0;
          //lasttime = millis();
        }
      }
  
      //print("new point " + prevx + prevy + "\n" + randomX + " " + randomY);
    } else {
    //ellipse(xpos, ypos, diam, diam);
      if((dx > 0)) {
        animation1.display(xpos-animation1.getWidth()/2, ypos);
      } else {
        animation2.display(xpos-animation1.getWidth()/2, ypos);
      }
      
    }
  }
  
}
//Canvas size 4608 x 1360
/*Animation animation1;
Animation animation2;
Animation animation3;
Animation animation4;*/
//int diam = 30;
//float xpos;
//float ypos;
float drag = 50.0; 
//float randomX; 
//float randomY;
//float dx;
//float dy;
//float exponent = 5;
//float pct = 0.0;
//float step = 0.01;
//float prevx;
//float prevy;
//int previndex;

int numofbranches;
FloatList xbranches;
FloatList ybranches;
PImage branch;
PImage branch_flipped;

int count = 0;
//int flag;

Bird bird1;
Bird bird2;
Bird bird3;

void setup() {
  //full size needed
  //size(4608, 1360);
  size(768, 1360);
  frameRate(20);
  //surface.setResizable(true);
  
  //generate random branches
  createBranches();
  branch = loadImage("branch.png");
  branch_flipped = loadImage("branch_flipped.png");
  
  bird1 = new Bird();
  bird2 = new Bird();
  bird3 = new Bird();
  //generate bird
  
}

void draw() {
  background(102);
  //image(branch, 300, 300);
  //print(xbranches.get(0));
  for(int i = 0; i < numofbranches+1; i++){
    float x = xbranches.get(i);
    float y = ybranches.get(i);
    //print(x);
    //print(y);
    if(x == width-400){
      image(branch,x,y,400,136);
    } else {
      image(branch_flipped,x,y,400,136);
    }  
  }
  
  bird1.update();
  if (count > 5);{
    bird2.update();
  }
  if (count > 10){
    bird3.update();
  }
  count++;

}


void createBranches() {

  xbranches = new FloatList();
  ybranches = new FloatList();
  numofbranches = int(random(3,6));
  for(int i = 0; i<numofbranches+1; i++){
      float x;
      if (int(random(0,2.0)) < 1){
        x = 0;
      } else {
        x = width-400;
      }
      
      float y = random(height-100);
      print(x+"\n");
      print(y+"\n");
      xbranches.append(x);
      ybranches.append(y);
  }
}

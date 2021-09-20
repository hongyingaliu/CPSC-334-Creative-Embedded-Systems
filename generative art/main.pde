
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
    if (flag != 1) {
      frame = (frame+1) % imageCount;
      image(images[frame], xpos, ypos, 250,250);
    } else {
      PImage stopped = loadImage("birb_landing/8.gif");
      image(stopped, xpos, ypos, 250, 250);
      print("stoped");
    }

  }
  
  void display_once(float xpos, float ypos) {
    image(images[a], xpos, ypos, 250,250);
    a++;
  }
  
  int getWidth() {
    return 250;
  }
}
//Canvas size 4608 x 1360
Animation animation1;
Animation animation2;
Animation animation3;
Animation animation4;
int diam = 30;
float xpos;
float ypos;
float drag = 50.0; 
float randomX; 
float randomY;
float dx;
float dy;
float exponent = 5;
float pct = 0.0;
float step = 0.01;
float prevx;
float prevy;

int numofbranches;
FloatList xbranches;
FloatList ybranches;
PImage branch;
PImage branch_flipped;
int previndex;

int lasttime;
int a;
int flag;

void setup() {
  //full size needed
  //size(4608, 1360);
  size(768, 1360);
  frameRate(20);
  //surface.setResizable(true);
  
  //animation 1 = new Animation();
  //ellipseMode(RADIUS);
  createBranches();
  genPoint();
  prevx = randomX;
  prevy = randomY;
  xpos = prevx;
  ypos = prevy;
  genPoint();
  lasttime = 0;
  flag = 0;
  //dx = randomX - prevx;
  //dy = randomY - prevy;
  animation1 = new Animation("birb/", 8);
  animation2 = new Animation("birb_flipped/", 8);
  animation3 = new Animation("birb_landing/", 14);
  animation4 = new Animation("birb_landing_flipped/", 9);
  branch = loadImage("branch.png");
  branch_flipped = loadImage("branch_flipped.png");
  //generate random branches
  
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
  
  update();
  //print("x: " + xpos + "y; " + ypos + "\n");
  //dx = randomX - xpos;
  //dy = randomY - ypos;
  

  
  /*if (pct > 0.9 && pct < 0.99 && a!=9) {
     if(dx > 0){
       animation3.display(xpos-animation1.getWidth()/2, ypos);
     } else {
       animation4.display(xpos-animation1.getWidth()/2, ypos);
     }
  }*/
  //xpos = xpos + dx/drag;
  //ypos = ypos + pow(pct, exponent)*(dy/drag);
  //if ((randomX - 1 < xpos && xpos < randomX + 1) && (randomY - 1 < ypos && ypos < randomY + 1)){

  /*if((dx > 0)&&(pct<0.9)) {
    animation1.display(xpos-animation1.getWidth()/2, ypos);
  } else {
      if((dx < 0)&&(pct<0.9)){
        animation2.display(xpos-animation1.getWidth()/2, ypos);
      }
       if((dx > 0)&&(pct>0.9)){
        animation3.display(xpos-animation1.getWidth()/2, ypos);
      }
       if((dx < 0)&&(pct>0.9)){
        animation4.display(xpos-animation1.getWidth()/2, ypos);
      }     
  }*/
  //choose landing point
  //go towards landing point
}

void update() {
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
        animation1.display(xpos-animation1.getWidth()/2, ypos);
        return;
      }
      
      if (flag == 1) {
         delay(2000);
         flag = 0;
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
        print(pct + "/n");
        genPoint();
        pct = 0.0;
        lasttime = millis();
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

void genPoint() {
//  randomX = random(width);
//  randomY = random(height-100);
    int index = int(random(0,numofbranches));
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
    print("new point");
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

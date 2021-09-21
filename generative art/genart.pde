
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

class Box {
  int index;
  int a;
  int b;
  int c;
  FloatList xbranches;
  FloatList ybranches;
  int numofbranches;
  PImage branch;
  PImage branch_flipped;
  Bird bird1;
  Bird bird2;
  //Bird bird3;
  int count = 0;
  int coin = int(random(0,2));

  
  Box(int i) {
    index = i;
    a = int(random(20,255));
    b = int(random(20,255));
    c = int(random(20,255));
    rect(index*1360, 0, 1360, 768);
    fill(a,b,c);
    branch = loadImage("branch.png");
    branch_flipped = loadImage("branch_flipped.png");

    

  }
  
  void update() {
    rect(index*1360, 0, 1360, 768);
    fill(a,b,c); 
    
    for(int i = 0; i < numofbranches+1; i++){
      float x = xbranches.get(i);
      float y = ybranches.get(i);
      
      if (y == 0.0) {
        image(branch_flipped,x,y,136,400);
        //print("nothere");
      } else {
        //print("AAAA");
        image(branch,x,y,136,400);
      }
    }
    
    bird1.update();
    if (coin == 0 && (count > 5)){
      bird2.update();
    }/*
    if (count > 10){
      bird3.update();
    }*/
    count++;
  }
  
  void createBranches() {
    xbranches = new FloatList();
    ybranches = new FloatList();
    numofbranches = int(random(2,5));
    for(int i = 0; i<numofbranches+1; i++){
      float y;
      int chance = int(random(2));
      //print(chance);
      if (chance == 1){
        y = 0;
      } else {
        y = 768-400;
      }    
      //print(y);
      float x = random((index*1360)+20, (index*1360)+1160);
      xbranches.append(x);
      ybranches.append(y);
    }
  }
  
  void createBirds(){
    bird1 = new Bird();
    if (coin == 0) {bird2 = new Bird();}
    //bird3 = new Bird();
  }
  
 /////////////////// 
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
    int previndex = 100;
    int flag = 0;
    int lasttime = 0;
    int currenttime;
    int a;
    float drag = 50.0;
    Animation animation1;
    Animation animation2;
    Animation animation3;
    Animation animation4;
    
    Bird(){
      //generate start point
      genPoint();
      //print("birb");
      prevx = randomX;
      prevy = randomY;
      xpos = prevx;
      ypos = prevy;
      genPoint();
      animation1 = new Animation("birb/", 8);
      animation2 = new Animation("birb_flipped/", 8);
      animation3 = new Animation("birb_landing/", 9);
      animation4 = new Animation("birb_landing_flipped/", 9);
    }
    
    void genPoint(){
      int index = int(random(0, numofbranches));
      if(index == previndex) {
        if(index != numofbranches-1) {
          index = index + 1;
        } else {
          index = index - 1;
        }
      }
      
      previndex = index;
      randomX = xbranches.get(index) + 40;
      randomY = ybranches.get(index) + random(20, 100);
    }
    
    void update() {
      dx = randomX - prevx;
      dy = randomY - prevy;
      pct += step;
      
      if (pct < 1.0) {
        //!!
        xpos = prevx + (pct * dx);
        ypos = prevy + (pow(pct, exponent) * dy);
      } 
      if (pct > 0.94) {
        if(pct < 0.99) {
          flag = 2;
          if(dy > 0){
            animation3.display(xpos-animation1.getWidth()/2, ypos);            
          } else {
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
             if(millis()-lasttime < 3000){
               animation1.stop(xpos-animation1.getWidth()/2, ypos);
             } else {
               flag = 0;
             }            
          } else {
              prevx = randomX;
              prevy = randomY;
              genPoint();
              pct = 0.0;
          }
        }
      } else {
        if((dy > 0)) {
          animation1.display(xpos-animation1.getWidth()/2, ypos);
        } else {
          animation2.display(xpos-animation1.getWidth()/2, ypos);
        }        
      }   
    }
  }  

}




//////////
Box box1;
Box box2;
Box box3;
Box box4;
Box box5;
Box box6;

void setup() {
  //full size 
  size(8160, 768);
  frameRate(16);
  //size(1360, 768);
  box1 = new Box(0);
  box1.createBranches();
  box1.createBirds();
  
  box2 = new Box(1);
  box2.createBranches();
  box2.createBirds();
  
  box3 = new Box(2);
  box3.createBranches();
  box3.createBirds();
  
  box4 = new Box(3);
  box4.createBranches();
  box4.createBirds();
  
  box5 = new Box(4);
  box5.createBranches();
  box5.createBirds(); 
  
  box6 = new Box(5);
  box6.createBranches();
  box6.createBirds();  
}

void draw() {
  box1.update();
  box2.update();
  box3.update();
  box4.update();
  box5.update();
  box6.update();
}

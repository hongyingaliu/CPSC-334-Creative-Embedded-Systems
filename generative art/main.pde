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
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
//Canvas size 4608 x 1360
Animation animation1;
Animation animation2;
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

void setup() {
  //full size needed
  //size(4608, 1360);
  size(768, 1360);
  frameRate(24);
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
  //dx = randomX - prevx;
  //dy = randomY - prevy;
  animation1 = new Animation("/Users/AlanaLiu/documents/processing/generativeart/bluebirb/", 8);
  animation2 = new Animation("/Users/AlanaLiu/documents/processing/generativeart/bluebirb_flipped/", 8);
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
  //print("x: " + xpos + "y; " + ypos + "\n");
  //dx = randomX - xpos;
  //dy = randomY - ypos;
  dx = randomX - prevx;
  dy = randomY - prevy;
  pct += step;
  if (pct < 1.0) {
    xpos = prevx + (pct * dx);
    ypos = prevy + (pow(pct, exponent) * dy);
  }
  //xpos = xpos + dx/drag;
  //ypos = ypos + pow(pct, exponent)*(dy/drag);
  if ((randomX - 1 < xpos && xpos < randomX + 1) && (randomY - 1 < ypos && ypos < randomY + 1)){
    prevx = randomX;
    prevy = randomY;
    //choose new point
    genPoint();
    pct = 0.0;
    
    delay(2000);
    //print("new point " + prevx + prevy + "\n" + randomX + " " + randomY);
  }
  //ellipse(xpos, ypos, diam, diam);
  if(dx > 0) {
    animation1.display(xpos-animation1.getWidth()/2, ypos);
  } else {
    animation2.display(xpos-animation1.getWidth()/2, ypos);
  }
  

  
  //choose landing point
  //go towards landing point
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
    randomY = ybranches.get(index) - 130;
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

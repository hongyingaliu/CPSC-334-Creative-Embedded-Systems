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
float exponent = 4;
float pct = 0.0;
float step = 0.01;
float prevx;
float prevy;

void setup() {
  //full size needed
  //size(4608, 1360);
  size(768, 1360);
  frameRate(24);
  //surface.setResizable(true);
  
  //animation 1 = new Animation();
  //ellipseMode(RADIUS);
  xpos = width/2;
  ypos = height/2;
  prevx = width/2;
  prevy = height/2;
  randomX = 20;
  randomY = 20;
  //dx = randomX - prevx;
  //dy = randomY - prevy;
  animation1 = new Animation("/Users/AlanaLiu/documents/processing/generativeart/bluebirb/", 8);
  animation2 = new Animation("/Users/AlanaLiu/documents/processing/generativeart/bluebirb_flipped/", 8);
  
}

void draw() {
  background(102);
  print("x: " + xpos + "y; " + ypos + "\n");
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
  if ((randomX - 10 < xpos && xpos < randomX + 10) && (randomY - 10 < ypos && ypos < randomY + 10)){
    prevx = randomX;
    prevy = randomY;
    genPoint();
    pct = 0.0;
    print("new point");
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
  randomX = random(width);
  randomY = random(height-10);
}



//loadPixels(); access pixel array
//pixel location is always = x + y*width
//updatePixels();
//brightness threshold filter

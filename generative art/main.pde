
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
      
      print(y);
      if (y == 0.0) {
        image(branch_flipped,x,y,136,400);
        //print("nothere");
      } else {
        //print("AAAA");
        image(branch,x,y-400,136,400);
      }
    }
  }
  
  void createBranches() {
    xbranches = new FloatList();
    ybranches = new FloatList();
    numofbranches = int(random(2,6));
    for(int i = 0; i<numofbranches+1; i++){
      float y;
      int chance = int(random(2));
      print(chance);
      if (chance == 1){
        y = 0;
      } else {
        y = 768;
      }    
      print(y);
      float x = random((index*1360)+50, (index*1360)+1260);
      xbranches.append(x);
      ybranches.append(y);
    }
  }

}

Box box1;

void setup() {
  //full size 
  //size(8160, 768);
  size(1360, 768);
  box1 = new Box(0);
  box1.createBranches();
  
}

void draw() {
  box1.update();
}

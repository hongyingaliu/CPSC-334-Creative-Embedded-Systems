//This program runs a generative art animation with birds, branches, and colored boxes

//Class to handle loading images into a looping animation 
class Animation {
  //create array of all images in a gif
  PImage[] images;
  //number of images in array
  int imageCount;
  //keeps track of which frame animation is on
  int frame;
  
  //Animation object, takes input of the common prefix and numner of images
  Animation(String imagePrefix, int count){
    imageCount = count;
    images = new PImage[imageCount];
    
    //instead of calling every file location, putting all the files in a folder
    //and titling each gif with it's numeric order saves code
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + str(i) + ".gif";
      //load images into array
      images[i] = loadImage(filename);
    }
  }
  
  //function to display the write image in gif loop
  void display(float xpos, float ypos) {
      //mod allows the order to be kept correct even though frame number grows
      frame = (frame+1) % imageCount;
      //display at the specified coordinates (x,y) at 250 pixel width/heigh
      image(images[frame], xpos, ypos, 250,250);
  }
  
  //special function to display the bird resting after having landed
  void stop(float xpos, float ypos) {
      PImage stopped = loadImage("birb_landing/8.gif");
      image(stopped, xpos, ypos, 250, 250);
  } 
  
  //return width of image; more useful when width used to not be numerically specified
  int getWidth() {
    return 250;
  }
}

//Class to delegate all other objects specifically to one box/"projector"
//basically treat each projector individually
class Box {
  int index;  //
  int a;  //rgb first variable
  int b;  //rgb second variable
  int c;  //rgb third variable
  FloatList xbranches;    //list of randomly generated branch x coordinates
  FloatList ybranches;    //list of randomly generated branch y coordinates
  int numofbranches;    //number of branches
  PImage branch;    //variable for branch
  PImage branch_flipped;    //variable for branch other side
  Bird bird1;   //variable for 1st bird object
  Bird bird2;   //variable for 2nd bird object
  //Bird bird3;
  int count = 0;    //variable to help delay pacing of separate bird animations
  int coin = int(random(0,2));    //decide whether to spawn 2nd bird or not

  //create box object
  Box(int i) {
    index = i;    //determines which segment of the screen box is
    //randomly generate box colors
    a = int(random(20,255));    
    b = int(random(20,255));
    c = int(random(20,255));
    //draw rectangle
    rect(index*1360, 0, 1360, 768);
    //fill randomized color
    fill(a,b,c);
    //load branch images
    branch = loadImage("branch.png");
    branch_flipped = loadImage("branch_flipped.png");
  }
  
  //function to be run every frame of animation
  void update() {
    //redraw rectangles
    rect(index*1360, 0, 1360, 768);
    fill(a,b,c); 
    
    //redraw branches
    for(int i = 0; i < numofbranches+1; i++){
      //retrieve saved coordinates
      float x = xbranches.get(i);
      float y = ybranches.get(i);
      
      //depending on y orientation choose correctly oriented image
      if (y == 0.0) {
        image(branch_flipped,x,y,136,400);
      } else {
        image(branch,x,y,136,400);
      }
    }
    
    //call bird's update functions
    bird1.update();
    //only run if bird object exists
    if (coin == 0 && (count > 5)){
      bird2.update();
    }/*
    if (count > 10){
      bird3.update();
    }*/
    count++;
  }
  
  //generate branch points
  void createBranches() {
    //save coordinates in float lists
    xbranches = new FloatList();
    ybranches = new FloatList();
    //choose random number of branches per box between 2-4
    numofbranches = int(random(2,5));
    //for each branch generate random coordinates
    for(int i = 0; i<numofbranches+1; i++){
      float y;
      int chance = int(random(2));
      //decide whether branch is on right or left side
      if (chance == 1){
        y = 0;
      } else {
        y = 768-400;
      } 
      float x = random((index*1360)+20, (index*1360)+1160);
      //append new points to list
      xbranches.append(x);
      ybranches.append(y);
    }
  }
  
  //create new bird objects, has to be done separately because birds
  //can only be created after branch points have been generated
  void createBirds(){
    bird1 = new Bird();
    if (coin == 0) {bird2 = new Bird();}
    //bird3 = new Bird();
  }
  
  //This class creates a bird object with individual behavior 
  class Bird {
    float xpos;   //current x coordinate of bird
    float ypos;   //current y coordinate of bird
    float randomX;    //future destination x coordinate of bird
    float randomY;    //future destination y coordinate of bird
    float prevx;    //x coordinate bird started from before
    float prevy;    //y coordinate bird started from before
    float dx;   //velocity of x
    float dy;   //velocity of y
    float exponent = 5;    //exponent to create curve
    float pct = 0.0;    //progress on bird's path
    float step = 0.01;    //add progress on bird's path
    int previndex = 100;    //saves the last index in array of points used
    int flag = 0;   //flag to let animation know when to pause
    int lasttime = 0;   //timer for pause
    int currenttime;    //variable to save time that has passed
    int a;    
    float drag = 50.0;    //modify speed of bird path
    //animation objects
    Animation animation1;   
    Animation animation2;
    Animation animation3;
    Animation animation4;
    
    //create bird object
    Bird(){
      //generate first random start point
      genPoint();
      prevx = randomX;
      prevy = randomY;
      xpos = prevx;
      ypos = prevy;
      //regenerate first starting point so all variables are filled
      genPoint();
      //specify animation image information
      animation1 = new Animation("birb/", 8);
      animation2 = new Animation("birb_flipped/", 8);
      animation3 = new Animation("birb_landing/", 9);
      animation4 = new Animation("birb_landing_flipped/", 9);
    }
    
    //fucntion to generate a new destination point for bird
    void genPoint(){
      int index = int(random(0, numofbranches));
      //logic to ensure bird can't choose the same branch it's already on
      if(index == previndex) {
        if(index != numofbranches-1) {
          index = index + 1;
        } else {
          index = index - 1;
        }
      }
      
      previndex = index;
      //randomly choose one of the branches
      randomX = xbranches.get(index) + 40;    //adjust for image gap by adding 40
      //add a random distance to where bird lands on branch so it's not always the same
      randomY = ybranches.get(index) + random(20, 100);
    }
    
    //function to be run every frame of bird animation
    void update() {
      //slope is start point - destination point
      dx = randomX - prevx;
      dy = randomY - prevy;
      pct += step;
      
      //if path hasn't been completed keep update points
      if (pct < 1.0) {
        xpos = prevx + (pct * dx);
        ypos = prevy + (pow(pct, exponent) * dy);
      } 
      
      //if path is almost complete
      if (pct > 0.94) {
        //and bird has not quite reached branch
        if(pct < 0.99) {
          //let animation know to get ready to pause
          //has to use two flags because new animations are only loaded once frame has passed
          flag = 2;
          //play landing animation
          if(dy > 0){
            animation3.display(xpos-animation1.getWidth()/2, ypos);            
          } else {
            animation4.display(xpos-animation1.getWidth()/2, ypos); 
          }
        } else {
          if (flag == 2) {
            //load stopped image for next frame 
            flag = 1;
            animation1.stop(xpos-animation1.getWidth()/2, ypos);
            lasttime = millis();
            //currenttime = millis();
            return;
          }  
          if (flag == 1) {
             //wait for 3000 milliseconds
             if(millis()-lasttime < 3000){
               animation1.stop(xpos-animation1.getWidth()/2, ypos);
             } else {
             //reset flag so it won't stop until flagged again
               flag = 0;
             }            
          } else {
          //reset all path related variables and create new destination
              prevx = randomX;
              prevy = randomY;
              genPoint();
              pct = 0.0;
          }
        }
      } else {
        //mid flight
        //determine orientatino of animation based on slope
        if((dy > 0)) {
          animation1.display(xpos-animation1.getWidth()/2, ypos);
        } else {
          animation2.display(xpos-animation1.getWidth()/2, ypos);
        }        
      }   
    }
  }  

}

//MAIN
//Box variables
Box box1;
Box box2;
Box box3;
Box box4;
Box box5;
Box box6;

//run once at start of program
void setup() {
  //set window size to size of Leeds screens
  size(8160, 768);
  //set frameRate
  frameRate(20);
  
  //create all box objects and relevant objects within
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

//run every frame of animation
void draw() {
  //run boxes' updates
  box1.update();
  box2.update();
  box3.update();
  box4.update();
  box5.update();
  box6.update();
}

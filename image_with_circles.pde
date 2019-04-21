import processing.serial.*;

Serial myPort;

PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;

float circleSize = 6;
float rightVelocityConstrained, leftVelocityConstrained, topVelocityConstrained, bottomVelocityConstrained;

int initialLineVelocity;

int springDisplacement;

int inByte; //value from arduino with initial value as rest position

boolean isCirclePresent[];

boolean velocityIsZero = false;

int keypressed;

int loc;

int lineNumber = 0;//initially nothing has moved

int cols, rows;
int x0, x1, y0, y1 = 0;

int xLeft, xRight, yTop, yBottom;
int xLeftFinal, xRightFinal, yTopFinal, yBottomFinal;

Line lineLeft;
Line lineRight;
Line lineTop;
Line lineBottom;

Circle pixelCircle;


void setup() {
  //fullScreen();
  size(900, 900);

  String portName = "/dev/cu.usbmodem1421";
  myPort = new Serial(this, portName, 9600);

  img = loadImage("minion.jpg");  // Make a new instance of a PImage by loading an image file
  background(255);
  smooth();
  cellSize = 5; //radius of the circle
  cols = img.width/cellSize;  // Number of columns
  rows = img.height/cellSize; 

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      int x = i*cellSize;
      int y = j*cellSize;
      loc = x + y*img.width; //standard formula to determine location of a pixel in the array
    }
  }

  //create a 2D boolean array with all false initially  
  isCirclePresent = new boolean[cols*rows]; //initializes everything to false
  //println(isCirclePresent.length);
  for (int i = 0; i < isCirclePresent.length; i++) {
    isCirclePresent[i] = false;
  }

  colorMode(RGB, 100);

  yBottom = height;
  xRight = width;
  yTop = 0; 
  xLeft = 0;


  //initialLineVelocity = map(springDisplacement, 20, 160, 0, 42.85); //20 ~ the distance it travels 
  lineLeft = new Line(xLeft, 0, xLeft, height, initialLineVelocity, color(0, 0, 0));
  lineRight = new Line(xRight, 0, xRight, height, initialLineVelocity, color(255, 0, 0));
  lineTop = new Line(0, yTop, width, yTop, initialLineVelocity, color(0, 0, 255));
  lineBottom = new Line(0, yBottom, width, yBottom, initialLineVelocity, color(0, 255, 0));
}

void draw() {
  //background(255, 255, 255);
  initialLineVelocity = (int)map(inByte, 42, 103, 1, 42);
  constrainVelocities();

  if (lineBottom.velocity == 0) 
    lineBottom.display();
  if (lineLeft.velocity == 0)
    lineLeft.display();
  if (lineTop.velocity == 0)
    lineTop.display();
  if (lineRight.velocity == 0)
    lineRight.display();

  //moveLines();

  if (keypressed == 5) {
    drawCircles(yTopFinal, yBottomFinal, xRightFinal, xLeftFinal);
  }

  delay(10);
}

//drawing circles
void drawCircles(int topY, int bottomY, int rightX, int leftX) {
  img.loadPixels();
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {

      int x = i*cellSize;
      int y = j*cellSize;
      int pixelLoc = x + y*img.width; //standard formula to determine location of a pixel in the array
      int circleLocation = i + j*cols; //array for number of circles is different from the pixel array

      float r = 255;
      float g = 255;
      float b = 255;
      //println("leftX:" + leftX+ " right x"+ rightX +  " topY"+ topY + "bottom Y" + bottomY);
      if ((x >= leftX && x < rightX && y>= topY && y < bottomY) || isCirclePresent[circleLocation] == true) {
        //println("i am drawing bro");
        r = red(img.pixels[pixelLoc]); //looking up rgb values of the image
        g = green(img.pixels[pixelLoc]);
        b = blue(img.pixels[pixelLoc]);
        isCirclePresent[circleLocation] = true;
      }
      pixelCircle = new Circle(r, g, b, x+cellSize/2, y+cellSize/2);
      pixelCircle.display();
    }
  }
}
//}


void resetLines() {
  lineLeft.resetLeft();
  lineRight.resetRight();
  lineTop.resetTop();
  lineBottom.resetBottom();
}

void constrainVelocities() {
  rightVelocityConstrained = constrain(lineRight.velocity, 0, 42.85);
  leftVelocityConstrained = constrain(lineLeft.velocity, 0, 42.85);
  topVelocityConstrained = constrain(lineTop.velocity, 0, 42.85);
  bottomVelocityConstrained = constrain(lineBottom.velocity, 0, 42.85);
}



void moveLines() {
  //when neo pixels change color decide which line is moving
  if (keypressed == 1) {

    lineBottom.moveUp();
    if (lineBottom.velocity == 0) {
      yBottomFinal = lineBottom.yPos1;
      // println(yBottomFinal);
    }
  } 
  if (keypressed == 2) {
    lineLeft.setVelocity(initialLineVelocity);
    lineLeft.moveRight();

    if (lineLeft.velocity == 0) {
      xLeftFinal = lineLeft.xPos2;
    }
  } 
  if (keypressed == 3) {
    lineTop.moveDown();

    if (lineTop.velocity == 0) {

      yTopFinal = lineTop.yPos2;
    }
  } 
  if (keypressed == 4) {

    lineRight.moveLeft();

    if (lineRight.velocity == 0) {

      xRightFinal = lineRight.xPos2;
    }
  } else {
  }
}

//key presses
void keyPressed() {
  switch(key) {
  case '1':
    keypressed = 5;
    resetLines();
    //resetAllLines();
    break;
  }

  //setting the initial velocity each time
  if (key == 'q') {

    keypressed = 1;
    lineBottom.setVelocity(initialLineVelocity);
    lineNumber++;
  }  
  if (key == 'w') {
    //keypressed = 2;
    //lineLeft.setVelocity(initialLineVelocity);
    //lineNumber++;
  } 
  if (key == 'e') {
    keypressed = 3;
    lineTop.setVelocity(initialLineVelocity);
    lineNumber++;
  } 
  if (key == 'r') {

    keypressed = 4;

    lineRight.setVelocity(initialLineVelocity);
    //println(lineRight.velocity);
    lineNumber++;
  }
}


void serialEvent (Serial myPort) {
  // get the byte:
  while (myPort.available()>0) {
    inByte = myPort.read();
    //println("serial");
    println(inByte);
    keypressed = 2;
    moveLines();
  }
 
}



/*
Fixes
 1. add condition "&& the last player has played" before circles are drawn: linenmber reaches 4 and velocity is 0
 2. When one line is moving, the other one cannot
 */

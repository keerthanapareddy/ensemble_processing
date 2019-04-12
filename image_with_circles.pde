import processing.serial.*;

//Serial myPort;

PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;

float circleSize = 6;
float rightVelocityConstrained, leftVelocityConstrained, topVelocityConstrained, bottomVelocityConstrained;

float initialLineVelocity;

int springDisplacement=70 ;

int inByte; //value from arduino with initial value as rest position

boolean isCirclePresent[];

boolean velocityIsZero = false;

int keypressed;

int loc;

int lineNumber = 0;//initially nothing has moved

int cols, rows;
int x0, x1, y0, y1 = 0;

float xLeft, xRight, yTop, yBottom;

Line lineLeft;
Line lineRight;
Line lineTop;
Line lineBottom;

Circle pixelCircle;


void setup() {
  //fullScreen();
  size(900, 900);

  //String portName = "/dev/cu.usbmodem1411";
  //myPort = new Serial(this, portName, 9600);

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
  background(255, 255, 255);
  initialLineVelocity = map(springDisplacement, 0, 140, 0, 42.85);
  constrainVelocities();
  //springLength = 50;

  //if (lineNumber == 4 && (rightVelocityConstrained == 0 || leftVelocityConstrained == 0 || topVelocityConstrained == 0 || bottomVelocityConstrained == 0)) {
  //  //println("entering");
  //  lineNumber = 0;
  //  resetLines();
  //}

  drawCircles();

  lineBottom.display();
  lineLeft.display();
  lineTop.display();
  lineRight.display();
  moveLines();

  delay(10);
}

void moveLines() {
  //when neo pixels change color decide which line is moving
  if (keypressed == 1) {
    lineBottom.moveUp();
  } else if (keypressed == 2) {
    lineLeft.moveRight();
  } else if (keypressed == 3) {
    lineTop.moveDown();
  } else if (keypressed == 4) {
    lineRight.moveLeft();
  } else {
  }
}


//drawing circles
void drawCircles() {

  img.loadPixels();
  int cols = img.width/cellSize;  // Number of columns
  int rows = img.height/cellSize;   // Number of rows
  //println(cols + " " + rows);

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {

      int x = i*cellSize;
      int y = j*cellSize;
      int loc = x + y*img.width; //standard formula to determine location of a pixel in the array
      int locCircles = i + j*cols; //array for number of circles is different from the pixel array

      float r = 255;
      float g = 255;
      float b = 255;

      //if (isCirclePresent[locCircles] == false) { //if circles are not present at that location, only then draw
      //*** calculate column number of the line

      //add condition "&& the last player has played"

      if (lineNumber == 4 &&  rightVelocityConstrained == 0) {
        lineNumber = 0;
        resetLines();
        //if ((i > lineLeft.xPos1 && i < lineRight.xPos1 && j > lineTop.yPos1 && j < lineBottom.yPos2) || isCirclePresent[locCircles] == true) { //== true saves the previous drawn square
          if ((i > 40 && i < 150 && j > 100 && j < 150) || isCirclePresent[locCircles] == true) {
          println("i am drawing bro");
          r = red(img.pixels[loc]); //looking up rgb values of the image
          g = green(img.pixels[loc]);
          b = blue(img.pixels[loc]);
          isCirclePresent[locCircles] = true;
        }
        pixelCircle = new Circle(r, g, b, x+cellSize/2, y+cellSize/2);
        pixelCircle.display();
      }
    }
  }
}

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

//key presses
void keyPressed() {
  switch(key) {
  case '1':
    x0 = 77; 
    x1 = 115;
    y0 = 37;
    y1 = 125;
    drawCircles();
    //resetAllLines();
    break;

  case '2':
    x0 = 40;
    x1 = 60;
    y0 = 40;
    y1 = 60;
    drawCircles();
    //resetAllLines();
    break;

  case '3':
    x0 = 60;
    x1 = 80;
    y0 = 40;
    y1 = 60;
    drawCircles();
    //resetAllLines();
    break;

  case '4':
    x0 = 0;
    x1 = width;
    y0 = 0;
    y1 = height;
    drawCircles();
    break;
  }

  //setting the initial velocity each time
  if (key == 'q') {
    keypressed = 1;
    lineBottom.setVelocity(initialLineVelocity);
    lineNumber++;
    return lineBottom.yPos1;
  }  

  if (key == 'w') {
    keypressed = 2;
    lineLeft.setVelocity(initialLineVelocity);
    lineNumber++;
  } 
  if (key == 'e') {
    keypressed = 3;
    lineTop.setVelocity(initialLineVelocity);
    lineNumber++;
  } 
  if (key == 'r') {
    keypressed = 4;
    lineRight.setVelocity(initialLineVelocity);
    lineNumber++;
  }
}

/*
void serialEvent (Serial myPort) {
 // get the byte:
 while (myPort.available()>0) {
 inByte = myPort.read();
 springDisplacement = (inByte-2)*10;
 //println(springDisplacement*10);
 }
 }
 */


/*
Fixes
 1. add condition "&& the last player has played" before circles are drawn: linenmber reaches 4 and velocity is 0
 2. When one line is moving, the other one cannot
 */

PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;

float circleSize = 5;


float initialLineVelocity;

float springLength = 50;

boolean isCirclePresent[];

int keypressed;

int loc;

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
  img = loadImage("minion.jpg");  // Make a new instance of a PImage by loading an image file
  background(0);
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

  initialLineVelocity = map(springLength, 0, 50, 0, 20);
  lineLeft = new Line(xLeft, 0, xLeft, height, initialLineVelocity);
  lineRight = new Line(xRight, 0, xRight, height, initialLineVelocity);
  lineTop = new Line(0, yTop, width, yTop, initialLineVelocity);
  lineBottom = new Line(0, yBottom, width, yBottom, initialLineVelocity);

  drawCircles();
}

void draw() {
  //springLength = 50;



  background(0);
  drawCircles();

  if (keypressed == 1) {
    lineBottom.display();
    lineBottom.moveUp();
  } 
  if (keypressed == 2) {

    lineLeft.display();
    lineLeft.moveRight();
  }
  if (keypressed == 3) {
    lineTop.display();
    lineTop.moveDown();
  } 
  if (keypressed == 4) {
    lineRight.display();
    lineRight.moveLeft();
  }

  lineBottom.display();
  lineLeft.display();
  lineTop.display();
  lineRight.display();
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

      float r = 0;
      float g = 0;
      float b = 0;

      //if (isCirclePresent[locCircles] == false) { //if circles are not present at that location, only then draw
      //*** calculate column number of the line
      if ((i > x0 && i < x1 && j > y0 && j < y1) || isCirclePresent[locCircles] == true) { //== true saves the previous drawn square

        r = red(img.pixels[loc]); //looking up rgb values of the image
        g = green(img.pixels[loc]);
        b = blue(img.pixels[loc]);
        isCirclePresent[locCircles] = true;
      }

      pixelCircle = new Circle(r, g, b, x+cellSize/2, y+cellSize/2);
      pixelCircle.display();
    }
    //}
  }
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
    break;

  case '2':
    x0 = 40;
    x1 = 60;
    y0 = 40;
    y1 = 60;
    drawCircles();
    break;

  case '3':
    x0 = 60;
    x1 = 80;
    y0 = 40;
    y1 = 60;
    drawCircles();
    break;

  case '4':
    x0 = 0;
    x1 = width;
    y0 = 0;
    y1 = height;
    drawCircles();
    break;
  }

  //each key gives different spring length
  if (key == 'q') {
    keypressed = 1;
  }  
  if (key == 'w') {
    keypressed = 2;
  } 
  if (key == 'e') {
    keypressed = 3;
  } 
  if (key == 'r') {
    keypressed = 4;
  }
}

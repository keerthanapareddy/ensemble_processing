PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;

float circleSize = 0;
color c;

float circleSiz;

boolean isCirclePresent[];

int loc;

int cols, rows;
int x0, x1, y0, y1 = 0;

void setup() {
  size(1000, 500);
  img = loadImage("mario.jpg");  // Make a new instance of a PImage by loading an image file
  background(0);
  noStroke();
  smooth();

  cellSize = 7; //radius of the circle

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
  println(isCirclePresent.length);
  for (int i = 0; i < isCirclePresent.length; i++) {
    isCirclePresent[i] = false;
  }

  colorMode(RGB, 100);
}

void draw() {


  if ((circleSize == 0) || (circleSize < 8)) {
    //drawCircles();
    animateCircles();
  } else {
  }
  //delay(70);
}


void drawCircles() {

  img.loadPixels();
  int cols = img.width/cellSize;  // Number of columns
  int rows = img.height/cellSize;   // Number of rows
  println(cols + " " + rows);

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {

      int x = i*cellSize;
      int y = j*cellSize;
      int loc = x + y*img.width; //standard formula to determine location of a pixel in the array
      int locCircles = i + j*cols; //array for number of circles is different from the pixel array

      float r = 0;
      float g = 0;
      float b = 0;
      
     if(isCirclePresent[locCircles] == false) { //if circles are not present at that location, only then draw
      if ((i > x0 && i < x1 && j > y0 && j < y1) || isCirclePresent[locCircles] == true) { //== true saves the previous drawn square
        
        r = red(img.pixels[loc]); //looking up rgb values of the image
        g = green(img.pixels[loc]);
        b = blue(img.pixels[loc]);
        isCirclePresent[locCircles] = true;
      }


      pushMatrix(); //draw ellipse      
      

        translate( x+cellSize/2, y+cellSize/2 );
      
          fill(r, g, b, 100);   
          ellipse(0, 0, circleSiz, circleSiz);
     
        popMatrix();
     }
    }
  }
}

void animateCircles() {
  circleSize = circleSize + 0.5; //"0.5" can be a value from arduino
  circleSiz = constrain(circleSize, 0, 7);
  //println(circleSiz);
}

void keyPressed() {
  switch(key) {
  case 'a':
    x0 = 30; 
    x1 = 50;
    y0 = 30;
    y1 = 50;
    drawCircles();
    break;
    
  case 's':
    x0 = 40;
    x1 = 60;
    y0 = 40;
    y1 = 60;
    drawCircles();
    break;
    
  case 'd':
    x0 = 60;
    x1 = 80;
    y0 = 40;
    y1 = 60;
    drawCircles();
    break;
  }
}

//radians = 2 * PI * (degrees / 360)

//take a random square area
//if no circles, draw circles
//if circles, choose another random square area

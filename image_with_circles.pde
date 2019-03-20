PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;
color c;

void setup() {
  size(1000,500);
  img = loadImage("mario.jpg");  // Make a new instance of a PImage by loading an image file
  background(0);
  noStroke();
  smooth();
  
  cellSize = 7;
  
  colorMode(RGB, 100);
  
  drawCircles();
}

void draw(){
}

void drawCircles(){
   img.loadPixels();
   int cols = img.width/cellSize;  // Number of columns
   int rows = img.height/cellSize; // Number of rows
   
   for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      int x = i*cellSize;
      int y = j*cellSize;
      int loc = x + y*img.width;
      
      float r = red(img.pixels[loc]); //looking up rgb values of the image
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      c = color(r,g,b);
      
      pushMatrix();
      translate( x+cellSize/2, y+cellSize/2 );
      fill(r,g,b,100);
      ellipse(0, 0, cellSize, cellSize);
      popMatrix();
    }
   }
      
}

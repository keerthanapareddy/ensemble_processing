PImage img; // Declare a variable of type PImage
//int circleSize = 5; //size of the circles
int cellSize;

float circleSize = 0;
color c;

float circleSiz;

int x,y;

boolean isCirclePresent[];

int cols,rows;

int loc;

void setup() {
  
  size(1000,500);
  img = loadImage("mario.jpg");  // Make a new instance of a PImage by loading an image file
  background(0);
  noStroke();
  smooth();
  
  cellSize = 7; //radius of the circle
 
  
  //circleSize = 0;
   cols = img.width/cellSize;  // Number of columns
   rows = img.height/cellSize; 
   
   for(int i=0; i<cols; i++){
      for(int j=0; j<rows; j++){
        x = i*cellSize;
        y = j*cellSize;
        loc = x + y*img.width; //standard formula to determine location of a pixel in the array
      }
   }
   //println(loc);
 
 //create a 2D boolean array with all false initially
 isCirclePresent = new boolean[loc]; //initializes everything to false
 println(isCirclePresent.length);
 for (int i = 0; i < isCirclePresent.length ; i++) {
   isCirclePresent[i] = false;
 }
 //println(isCirclePresent);
 
  colorMode(RGB, 100);   
   
}

void draw(){

   //when circles are drawn, at that location change it to true
   
  //when redrawing circles, if the location has true skip drawing circle there.
  //if still false, draw circles.
   //drawCircles();
   
  
     if((circleSize == 0) || (circleSize < 8)){
         //drawCircles();
         animateCircles();
     }
     else{
     }
  
   
   delay(70);
   
  
}



void drawCircles(){
     
  for(int i=0; i<cols; i++){
      for(int j=0; j<rows; j++){
        
       x = i*cellSize;
       y = j*cellSize;
       loc = x + y*img.width; //standard formula to determine location of a pixel in the array
        
       img.loadPixels();
       float r = red(img.pixels[loc]); //looking up rgb values of the image
       float g = green(img.pixels[loc]);
       float b = blue(img.pixels[loc]);
       pushMatrix(); //draw ellipse      
       translate( x+cellSize/2, y+cellSize/2 );
       fill(r,g,b,100);   
       ellipse(0, 0, circleSize, circleSize);
       popMatrix(); 
       
        for(int k=0; k<loc-1; k++){
           isCirclePresent[k] = true;
        }
      }
  }
 

}

void animateCircles(){
   circleSize = circleSize + 0.5; //"0.5" can be a value from arduino
   circleSiz = constrain(circleSize, 0, 7);
   //println(circleSiz);
   
  
}

void keyPressed(){
  switch(key){
      case 'a':
    for(int k=0; k<loc-1; k++){
      
       if(isCirclePresent[k] == false){
          drawCircles();
          animateCircles();
       }
    }
      break;
  }
}

//radians = 2 * PI * (degrees / 360)

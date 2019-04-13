class Line {

  int xPos1;
  int yPos1;
  int xPos2;
  int yPos2;
  int velocity;
  float mass;
  color c;


  Line( int tempXPos1, int tempYPos1, int tempXPos2, int tempYPos2, int tempVelocity, color tempColor) {
    xPos1 = tempXPos1;
    yPos1 = tempYPos1;
    xPos2 = tempXPos2;
    yPos2 = tempYPos2;
    velocity = tempVelocity;
    mass = 2;
    c = tempColor;
  }

  void display() {
    stroke(c);
    strokeWeight(3);
    line(xPos1, yPos1, xPos2, yPos2);
  }

  void moveRight() {
    velocity = velocity-1; //can remove this if velocity gets mapped to springlength
    if (velocity > 0) {
      xPos1 = xPos1+velocity;
      xPos2 = xPos2+velocity;
    }
    xPos1 = constrain(xPos1, 0, width);
    xPos2 = constrain(xPos2, 0, width);   
    //println(velocity);
  }

  void moveDown() {
    velocity = velocity-1;//can remove this if velocity gets mapped to springlength
    if (velocity > 0) {
      yPos1 = yPos1+velocity;
      yPos2 = yPos2+velocity;
    }
    yPos1 = constrain(yPos1, 0, height);
    yPos2 = constrain(yPos2, 0, height);
  }

  void moveLeft() {
    velocity = velocity-1;//can remove this if velocity gets mapped to springlength
    if (velocity > 0) {
      xPos1 = xPos1-velocity;
      xPos2 = xPos2-velocity;
    }
    xPos1 = constrain(xPos1, 0, width);
    xPos2 = constrain(xPos2, 0, width);
  }

  void moveUp() {
    velocity = velocity-1;//can remove this if velocity gets mapped to springlength
    if (velocity > 0) {
      yPos1 = yPos1-velocity;
      yPos2 = yPos2-velocity;
    }
  }
  
   void resetLeft() {
    stroke(c);
    strokeWeight(3);
    xPos1 =  0;
    yPos1 =0;
    xPos2 = 0;
    yPos2 =height;
  }
  
   void resetRight() {
    stroke(c);
    strokeWeight(3);
    xPos1 =  width;
    yPos1 =0;
    xPos2 = width;
    yPos2 =height;
  }
  
   void resetTop() {
    stroke(c);
    strokeWeight(3);
    xPos1 =  0;
    yPos1 =0;
    xPos2 = width;
    yPos2 =0;
  }
  
   void resetBottom() {
    stroke(c);
    strokeWeight(3);
    xPos1 =  0;
    yPos1 =height;
    xPos2 = width;
    yPos2 =height;
  }
  
  void setVelocity(int v){
    velocity = v;
    //velocity = constrain(0, );
  }
}

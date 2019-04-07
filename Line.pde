class Line {

  float xPos1;
  float yPos1;
  float xPos2;
  float yPos2;
  float velocity;
  float mass;


  Line( float tempXPos1, float tempYPos1, float tempXPos2, float tempYPos2, float tempVelocity) {

    xPos1 = tempXPos1;
    yPos1 = tempYPos1;
    xPos2 = tempXPos2;
    yPos2 = tempYPos2;
    velocity = tempVelocity;
    mass = 2;
  }

  void display() {
    stroke(255, 255, 255);
    strokeWeight(3);
    line(xPos1, yPos1, xPos2, yPos2);
  }

  void moveRight() {
    velocity = velocity - 0.5; //can remove this if velocity gets mapped to springlength
    if (velocity > 0) {
      xPos1 = xPos1 + velocity;
      xPos2 = xPos2 + velocity;
    }
    xPos1 = constrain(xPos1, 0, width);
    xPos2 = constrain(xPos2, 0, width);   
    //println(velocity);
  }

  void moveDown() {
    velocity = velocity - 1;
    if (velocity > 0) {
      yPos1 = yPos1 + velocity;
      yPos2 = yPos2 + velocity;
    }
    yPos1 = constrain(yPos1, 0, height);
    yPos2 = constrain(yPos2, 0, height);
  }

  void moveLeft() {
    velocity = velocity - 0.6;
    if (velocity > 0) {
      xPos1 = xPos1 - velocity;
      xPos2 = xPos2 - velocity;
    }
    xPos1 = constrain(xPos1, 0, width);
    xPos2 = constrain(xPos2, 0, width);
  }

  void moveUp() {
    velocity = velocity - 0.7;
    if (velocity > 0) {
      yPos1 = yPos1 - velocity;
      yPos2 = yPos2 - velocity;
    }
    yPos1 = constrain(yPos1, 0, height);
    yPos2 = constrain(yPos2, 0, height);
  }
}

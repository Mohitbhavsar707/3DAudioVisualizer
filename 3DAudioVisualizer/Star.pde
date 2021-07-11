// Class for the random appearing stars near the top and bottom middle of the screen


class Star{
  float x; // x position
  float y; // y positon
  float radius1;
  float radius2;
  int npoints; // number of points on the shape
  float angle; 
  float halfAngle;
  float alpha;
  
  // constructor class to set predefined values
  Star(float x, float y, float radius1, float radius2, int npoints){
    this.x = x;
    this.y = y;
    this.radius1 = radius1;
    this.radius2 = radius2;
    this.npoints = npoints;
    this.angle = TWO_PI/ npoints; // finds number of points needed
    this.halfAngle = angle/2.0;
    this.alpha = 255;    
  }
  
  
  void drawShape(){
    alpha -=10;
    
    //Math obtained from https://processing.org/examples/star.html (processing offers examples)
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * radius2;
        float sy = y + sin(a) * radius2;
        vertex(sx, sy);
        sx = x + cos(a+halfAngle) * radius1;
        sy = y + sin(a+halfAngle) * radius1;
        vertex(sx, sy);
      }
  endShape(CLOSE);    
  }
  
  Boolean removeStar(){
  //if the star is totally transparent, remove from the list
  if(alpha > 0){
    return false;
  }
  else{
    return true;
  }
}
  
  
}

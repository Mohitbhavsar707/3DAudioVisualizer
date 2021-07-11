// Class for the circle in the middle

class Circle{
  float x; // X position
  float y; // Y position
  float a; // Alpha value
  float w; // width
  float h; // height
  color c; // colour of circle
  float sizeE; // size increment value
  
  
  //Constructor method to set default values
  Circle(float x, float y, float w, float h, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.a = 255;
    sizeE = random(1,10);
    
  }
  
  //Circle will always exand at a random value creating a nice circle animation/illusion
  void expandCircle(){
    w += sizeE;
    h += sizeE;
    a -= 10;
    fill(c, a);
    ellipse(x,y,w,h);

    
    
  }
  
  
  Boolean removeCircle(){
  //if the circle is totally transparent, remove from the list
  if(a > 0){
    return false;
  }
  else{
    return true;
  }
}
  
}

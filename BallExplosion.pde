// Class for the pink balls that explode vertically

class BallExplosion{
  float x; // X position
  float y; // Y position
  float a; // alpha
  float w; // width
  float mx; // movement amount x direction
  float my; // movement amount y directoin
  color col; // colour of the balls
 
  //Constructor method to set default values
  BallExplosion(float tempX, float tempY, float tempW, color col){
    this.x = tempX;
    this.y = tempY;
    this.w = tempW;
    this.a = 255;
    this.col = col;
    this.mx = random(-5,5);
    this.my = random(-100,100);
    
  }
  
  //Used to make balls explode within the set range
  void move(){
    x += mx;
    y += my;
    a -= 10;
     
  }
  
 
  //Making the explosion visible
  void display(){
   fill(col,a);
   stroke(col);
   ellipse(x,y,w,w);
  }
  

 Boolean removeBallStreak(){
  //if the ball is totally transparent, remove from the list
  if(a > 0){
    return false;
  }
  else{
    return true;
  }
}

  
}

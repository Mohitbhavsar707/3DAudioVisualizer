// Class for the 4 balls shooting towards the top and bottom corners of the screen


class Shooters {
  float x; // x position of shape
  float y; // y position of shape
  float a; //alpha (transparency)
  float w; //width of the shape
  float num; //movement amount for shapes
  color col; // colour of shooters
  

// constructor class to set predefined values
Shooters(float tempX, float tempY, float tempW, float num, color col) {
  this.x = tempX;
  this.y = tempY;
  this.w = tempW;
  this.a = 255;
  this.num = num;
  this.col = col;
    
 }

// method used to direct shapes to go towards the top left corner 
void moveTopLeft() 
  {
    x-= num * cos(-100);
    y-= num * sin(-100);
    a-= 10;
  }

// method used to direct shapes to go towards the bottom right corner 
void moveBottomRight() 
  {
    x+= num * cos(-100);
    y+= num * sin(-100);
    a-= 10;
  }

// method used to direct shapes to go towards the bottom left corner 
void moveBottomLeft() 
  {
    x-= num * cos(100);
    y-= num * sin(100);
    a-= 10;
  }

// method used to direct shapes to go towards the top right corner 
void moveTopRight() {
    x+= num * cos(100);
    y+= num * sin(100);
    a-= 10;
   }



Boolean removeShooter(){
  //if the ball is totally transparent remove from the list
  if(a > 0){
    return false;
  }
  else{
    return true;
  }
}

void displayShooters() {
  fill(col,a); 
  stroke(col);
  ellipse(x,y,w,w);  
  
  }
  
}

// Class for the the 3d Cubes


class Cube{
  float bounds; // how big the cube will be
  float x, y, z; // position values
  float startingZ = -10000; // how close to the screen will the cubes be
  float maxZ = 1000; // how far indepth will the Z value go
  float a; // alpha
  color stroke; 
  color randomCol; // colour of cubes

//Constructor method to set default values
  Cube(float x, float y, color colOne, color stroke){
    
    this.stroke = stroke;
    this.randomCol = colOne;
    this.bounds = 100;
    this.x = x;
    this.y = y;
    this.z = random(startingZ, maxZ); // makes cubes appear at random locations within the z value range
    this.a = 255;
    
  }
  
  
  void transferCubes(){
    a -= 10; 

    float d = map(mouseX, -100, width, -50, 50); // the user gets to control the speed of the cubes
    z +=d;
    
    //Creates 3D movement of cubes going into and coming towards the screen
    pushMatrix();
    translate(x,y,z);
    fill(randomCol);
    stroke(stroke);
    box(bounds);
    popMatrix();
   
  }
  
    Boolean removeCubes(){
    //if the cube is totally transparent, remove from the list
      if(a > 0){
        return false;
       } else{
        return true;
       }
    }
}

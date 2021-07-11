// Main Audio visualizer Class
// Created by Mohit Bhavsar 2021 


import processing.sound.*;
SoundFile music;
Amplitude amp;

//Setting up FFT settings: Bands, smoothing factor, scale, bar width
FFT fft;
int bands = 256;
float smoothingFactor = 0.1;
float[] sum = new float[bands]; // change sum to spectrum
int scale = 1;
float barWidth;


//Initializing new arrayList for the different object classes
ArrayList<Cube> cubes;
ArrayList<Circle> circles;
ArrayList<BallExplosion> balls;
ArrayList<Star> stars;

ArrayList<Shooters> shootTopLeft;
ArrayList<Shooters> shootTopRight;
ArrayList<Shooters> shootBottomLeft;
ArrayList<Shooters> shootBottomRight;


//Primary colours used in the program - based on preference

color [] coloursSetOne = { 
     color(0,0,0), // 
     color(0,128,255), // blue
};

color [] coloursSetTwo = {  
     color(0,0,0), // 
      color(255,255,0), // yellow
};


color [] allColours = {  
     color(0,0,0), // 
     color(0,128,255), // blue
     color(255,255,0), // yellow
     color(255, 0, 150), // pink
};

// Variables to store random index values when traversing through the colour arrays
color randomColSetOne;
color randomColSetTwo;
color randomMainCol;
color primaryCol; // Pink 


//Used for middle rotating line
float deg = 499;
float rad = 499;
int s = 255;
float locX; // for star x position

//Determine star visibility timings
float timer; 
float elapsedTime;



void setup(){
  fullScreen(P3D); 
  //size(800,800,P3D);
  
  //Setting up music and amplitude
  music = new SoundFile(this, "C:\\Users\\MOHIT\\Desktop\\darkhorse.mp3");
  music.loop();
  amp = new Amplitude(this);
  amp.input(music);


  //Creating new objects
  cubes = new ArrayList<Cube>();
  circles = new ArrayList<Circle>();
  balls = new ArrayList<BallExplosion>();
  stars = new ArrayList<Star>();
  
  shootTopLeft = new ArrayList<Shooters>();
  shootTopRight = new ArrayList<Shooters>();
  shootBottomLeft = new ArrayList<Shooters>();
  shootBottomRight = new ArrayList<Shooters>();
  
  smooth(); // Bar transitions
  
  //FFT bar settings adjustments
  barWidth = 10* (height/float(bands));
  fft = new FFT(this, bands);
  fft.input(music);


  //rotation for middle line
  deg = random(360);
  
  
  //primary pink colour
  primaryCol = color(255, 0, 150);
  
  //for star popups
  timer = millis();

}

void draw(){

  background(0);
  lights(); // used for displaying 3D objects
  
  
  //Setting up the cube object and invoking Cube class methods
  for(int i = 0 ; i < cubes.size(); i++){
    Cube a = cubes.get(i);
    a.transferCubes();
    
    if ( a.removeCubes()){
      cubes.remove(i);
    }
  }
  
   //Setting up the exploding ball objects and invoking BallExplosion class methods
  for(int i = 0; i < balls.size(); i++){
    BallExplosion b = balls.get(i); 
    b.move();
    b.display();
    
    if ( b.removeBallStreak()){
       balls.remove(i);
    }
  }
  
    //Setting up the circle object and invoking Circle class methods
   for(int i = 0; i < circles.size(); i++){
     Circle c = circles.get(i);
     c.expandCircle();
      
     if(c.removeCircle()){
       circles.remove(i);
     }
   }
    
    //Setting up the ball shooting object and invoking methods from the Shooters class 
   for(int i = 0; i < shootTopLeft.size(); i++){
     Shooters d = shootTopLeft.get(i); 
     d.displayShooters();
     d.moveTopLeft(); // making the balls go towards the top left corners
      
     if(d.removeShooter()){
       shootTopLeft.remove(i);
     }
    }
    
   for(int i = 0; i < shootTopRight.size(); i++){
     Shooters e = shootTopRight.get(i); 
     e.displayShooters();
     e.moveTopRight(); // making the balls go towards the top right corners
      
     if(e.removeShooter()){
       shootTopRight.remove(i);
     }
   }
    
   for(int i = 0; i < shootBottomLeft.size(); i++){
    Shooters f = shootBottomLeft.get(i); 
    f.displayShooters();
    f.moveBottomLeft(); // making the balls go towards the bottom left corners
      
    if(f.removeShooter()){
      shootBottomLeft.remove(i);
    }
  }
      
   for(int i = 0; i < shootBottomRight.size(); i++){
    Shooters g = shootBottomRight.get(i);
    g.displayShooters();
    g.moveBottomRight(); // making the balls go towards the bottom right corners
    
    if(g.removeShooter()){
      shootBottomRight.remove(i);
    }
  }
    
   //Setting up the star object and invoking methods from the star class 
   for(int i = 0; i < stars.size(); i++){
    Star g = stars.get(i);  
    g.drawShape();
  
    if (g.removeStar()){
     stars.remove(i);
    }
  }
    
    
  //Assigning a variable to be used when comparing the volume that is being outputed from the music 
    float volume = amp.analyze() * 100;
    
    println(volume); // prints volume level to the console
    
    //Used to retrieve a random colour from the different arrays created
    randomColSetOne = coloursSetOne[(int)random(0,coloursSetOne.length)];
    randomColSetTwo = coloursSetTwo[(int)random(0,coloursSetTwo.length)];
    randomMainCol = allColours[(int)random(0,allColours.length)];

    
    //Checks the volume range and adds a specific set objects to display a unique pattern
    if (volume > 0 && volume < 15){ // first set of audio volume range patterns
          for(int i = 0; i < int(volume/2); i++){
               balls.add(new BallExplosion(width/2,height/2, random(10,20), primaryCol)); // creates the pink vertical ball explosions
             }
       } 
    
    if(volume > 15 && volume < 30){
           for(int i = 0; i < int(volume/5); i++){
               shootTopLeft.add(new Shooters(width/2,height/2, random(5,30), 50, randomColSetOne) ); // shapes added to be directed towards the top left
               shootBottomRight.add(new Shooters(width/2,height/2, random(5,30), 50, randomColSetTwo ) );  // shapes added to be directed towards the bottom right
               shootTopRight.add(new Shooters(width/2,height/2, random(5,30), 50, randomColSetTwo ) );  // shapes added to be directed towards the top right
               shootBottomLeft.add(new Shooters(width/2,height/2, random(5,30), 50, randomColSetOne ) ); // shapes added to be directed towards the bottom left
        
        //Used to create the middle rotating line
        drawRotatingLine();
      }  
    }
    
    
    
    if (volume > 50 && volume < 70){  // third set of audio volume range patterns
          for(int i = 0; i < int(volume/5); i++){
            cubes.add(new Cube(width/8, random(height), randomColSetOne, color(0,128,255))); // Creates #D blue cubes which are displayed on the left side
            cubes.add(new Cube(7 * (width/8), random(height), randomColSetTwo, color(255,255,0))); // Creates 3D yellow cubes which are displayed on the right side
            circles.add(new Circle(width/2, height/2, 50,50, randomMainCol)); // Creates center ever-changing circle
            
            randomStarSpawn(); // calls the method to spawn stars on the screen

            } 
        }  
  
    fft.analyze(); 
    for (int i = 0; i < bands; i++){ 
       fill(primaryCol);
       noStroke();
       sum[i] += fft.spectrum[i] - sum[i] * smoothingFactor; // used to determine the length of the bars(intensity)
       rect(width, height - i*barWidth, - (sum[i]*height*scale) / 10, barWidth/4); // Creates set of rectangle bars on the right side
       rect(0, i*barWidth, (sum[i]*width*scale) / 10, barWidth/4); // // Creates set of rectangle bars on the left side
    }
}


void drawRotatingLine(){
  fill(primaryCol);
        arc(width/2,height/2,rad,rad,deg*PI/180,(deg+1)*PI/180); // math behind line that goes in circles(uses arc class)
        deg++; // updating the rotation
        rad-=.04;
}



void randomStarSpawn(){
    locX = map(locX, 0, width, width/2, 2*(width/3)); // used to obtain a set range for the stars to appear on the screen
             elapsedTime = random(2000,6000); // Used to display stars after random time durations
             
             if(millis() - timer > elapsedTime){ // checks to see if the value for elapsed time has passed, if so, the elements are displayed
             
             //Used to create the star shape
                beginShape();
                pushMatrix();
                    stars.add(new Star(random(width/3, locX), height/5, 15,50,5));
                    stars.add(new Star(random(width/3, locX), 4*height/5, 15,50,5));
                popMatrix();
                endShape();
                    timer = millis(); // sets timer to the current time 
              }
}

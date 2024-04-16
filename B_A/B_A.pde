// Main File (sketch)

import processing.sound.*;
SoundFile arwSound;
SoundFile popSound;
SoundFile gameMusic;

PImage bckg1;
PImage bckg2;
PImage arc;
PImage arr; 
Archer archer;
Level level;
Score score;
Balloon b;
Balloon bY;
Arrow arrow;
int quiver = 20;
ArrayList<Balloon> balloons; // for red ballonons
ArrayList<Balloon> Yballoons; // for yellow balloons
ArrayList<Arrow> arrows;
int score1;
int score2;
int score3;
boolean  isYellow;
float acceleration;
//int redCounter = 0;

void setup() {
  size(800, 600);
  bckg1 = loadImage("data/imgs/backgrounds/IMG-20240415-WA0023.jpg");
  bckg2 = loadImage("data/imgs/backgrounds/IMGG-20240415-WA0025.jpg");
  arc = loadImage("data/imgs/chars/IiiMG-20240415-WA0003-removebg-preview.png");
  //arr = loadImage("imaaagesss (3).jpg");

  arwSound = new SoundFile(this,"sounds/arrow-impact-87260.mp3");
  popSound = new SoundFile(this,"sounds/balloon-pop-48030.mp3");

  //objects initializations
  archer = new Archer();
  balloons = new ArrayList<Balloon>();
    Yballoons = new ArrayList<Balloon>();
  arrows = new ArrayList<Arrow>();
  level = new Level(1); // Start with level 1
  score = new Score(quiver, 0); 
  resetLevel(); 
}

void draw() {
  score2 = score1 + score.calculateScore();
  background(200,280,190);
    String s1,s2,s3,s4;
  s1 = "Score:"; 
  s2 =  "  | Level: ";
  s3 =  "      | Arrows: ";
  s4 = "GG!";
  //colors at level one
  if(level.levelNumber == 1) {
      image(bckg1,0,0);
  textSize(20);  
    fill(40,0,13);
  text(s1 + score.calculateScore(), 20, 30 );
    fill(150,0,0);
  text(s2 + level.levelNumber, 100, 30);
    fill(40,0,13);
   text(s3 + quiver, 160, 30);
  }
  // change colors at level two
    if(level.levelNumber == 2){
        image(bckg2,0,0);
  textSize(20);
    fill(0,51,25);
 text(s1 + score2, 20, 30 );
    fill(51,0,101);
  text(s2 + level.levelNumber, 100, 30);
    fill(0,51,25);
   text(s3 + quiver, 160, 30);
 }
    archer.display();    //draw archer
  for (Balloon b : balloons) {  // Draw and move balloons
    b.display(); 
    b.move();   
  }
 
    if(level.levelNumber == 2)
    {
     for (Balloon bY : Yballoons) {  // Draw and move balloons
    bY.display(); 
    bY.move();   
  } 
    }
  
  
  // Draw and move arrows
  for (int i = arrows.size() - 1; i >= 0; i--) {
     arrow = arrows.get(i); 
    arrow.display();
    arrow.move(); 
    if (arrow.offScreen()) { 
      arrows.remove(i);
    }
  }
  
  // Check for collisions and update score
  for (int j = balloons.size() - 1; j >= 0; j--) {
     b = balloons.get(j);
    for (Arrow arw : arrows) {
      if (b.hit(arw)) {
        popSound.play();
        balloons.remove(j);
        score.shotBalloons++;
        break;
      }
    }
  }
  
  if(level.levelNumber == 2){
    for (int k = Yballoons.size() - 1; k >= 0; k--) {
     bY = Yballoons.get(k);
    for (Arrow arw : arrows) {
      if (bY.hit(arw)) {
        popSound.play();
        Yballoons.remove(k);
        score.shotBalloons++;
        break;
      }
    }
  }
}
  
  // Level Completed check
  if (level.isLevelCompleted()) {
    if (level.levelNumber == 1)
  {
    score1 = score.calculateScore(); // store the score of level 1
      level.levelNumber++;
       quiver = 20; // fill quiver
      resetLevel();
      score.remainingArrows = quiver;
      score.shotBalloons = 0;
      arrows.clear();
  }
    
    else if (level.levelNumber == 2) // check for three yellow here // once the 15 red shooted // show the end
    {
     fill (0,0,20);
     textSize(40);
     text(s4, (width/2)-80 , height/2);
     score3 = score.calculateScore();
     // remove remaining yellow balloons and quiver if exist
     Yballoons.clear();  
    quiver = 0;
    arrows.clear();
    score.remainingArrows = 0;
    }
      }      
}  // end of draw



void resetLevel() {
  balloons.clear(); 
  Yballoons.clear();
  if (level.levelNumber == 1) {
     //starting  positions
    float startX = width - 30; 
  float startY = height - 40;
    // Level 1:  15 red balloons aligned next to each other
    for (int i = 0; i < 15; i++) {
      balloons.add(new Balloon(startX - i * 30, startY, false, 0)); // fill balloons
    }
  }
      // 3 yellow balloons and 15 red balloons with random positions
  else if (level.levelNumber == 2) { // level 2 starts
          for (int i = 0; i < 15; i++) { // for red
     balloons.add(new Balloon (random(width-500, width-15) , random(height) , false , 0) ); 
  }
    for(int j = 0; j < 3; j++) {   // for 3 yellow
         isYellow = j < 3;
        acceleration = j < 3 ? random(0.000271,0.000301):0;
        Yballoons.add(new Balloon (random(width-430, width-150) , random(height) , isYellow , acceleration) ); 
    }  
  }
}

// mouse Controls
void mouseMoved() {
  archer.update(mouseY);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    //arwSound.play();
    if (quiver > 0) {
      arrows.add(archer.shoot()); //return an arrow object
      arwSound.play();
      quiver--;
      score.remainingArrows = quiver;// display on the screen
    }
  } 
  
  else if (mouseButton == RIGHT && quiver == 0 /*&& !balloons.isEmpty()*/ ) { // m7tag ashoof video el l3ba tany hna
  if(level.levelNumber == 1 && !balloons.isEmpty() )
  {
    quiver = 20;
    score.shotBalloons =0;
    resetLevel();
  }
  
else if(level.levelNumber == 2 && !balloons.isEmpty()) // check for just the red balloons
  {
        quiver = 20;
    score.shotBalloons =0;
    level.levelNumber = 2; // reset from level one 
    resetLevel();
  }
    }
}

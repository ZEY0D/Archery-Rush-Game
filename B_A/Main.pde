// Main File (sketch)

import processing.sound.*;
SoundFile arwSound;
SoundFile arwPull;
SoundFile popSound;
SoundFile buttonPress;
PImage bckg1;
PImage bckg2;
PImage bckgStart;
PImage arc;
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
boolean  isYellow;
float acceleration;
boolean flag;
boolean gameStart = false;

void setup() {
  size(800, 600);
  bckg1 = loadImage("imgs/backgrounds/IMG-20240415-WA0023.jpg");
  bckg2 = loadImage("imgs/backgrounds/IMG-20240418-WA0000.jpg");
  bckgStart = loadImage("imgs/backgrounds/startgame.jpg");
  arc = loadImage("imgs/chars/arcccher_boy2-01.png");
  arwSound = new SoundFile(this,"sounds/arrow-impact-87260.mp3");
  arwPull = new SoundFile(this,"sounds/arrowpull2.mp3");
  popSound = new SoundFile(this,"sounds/balloon-pop-48030.mp3");
  buttonPress = new SoundFile(this,"sounds/click-button-140881.mp3");
  //objects initializations
  archer = new Archer();
  level = new Level(1); // Start with level 1
  score = new Score(quiver, 0);
  balloons = new ArrayList<Balloon>();
  Yballoons = new ArrayList<Balloon>();
  arrows = new ArrayList<Arrow>();
}
void draw() {
  if(!gameStart) { // Startgame button
    image(bckgStart,0,0);
   if(mouseX > 250 && mouseX < 545 && mouseY < 375 && mouseY > 279 && mousePressed){
        gameStart = true;
        buttonPress.play();
        resetLevel();}
  }
  else{
  background(200,280,190);
    score2 = score1 + score.calculateScore();
    String s1,s2,s3,s4;
  s1 = "Score:"; 
  s2 =  "  | Level: ";
  s3 =  "      | Arrows: ";
  s4 = "CONGRATS!!";
  //colors at level one
  if(level.levelNumber == 1) {
      image(bckg1,0,0);
  textSize(20);  
    fill(40,0,13);
  text(s1 + score.calculateScore(), 20, 30 );
    fill(40,0,13);
  text(s2 + level.levelNumber, 100, 30);
    fill(40,0,13);
   text(s3 + quiver, 160, 30);
  }
   else if(level.levelNumber == 2){
        image(bckg2,0,0); // Theme changing
  textSize(20);
    fill(255,128,0);
 text(s1 + score2, 20, 30 ); // accumulated score
    fill(255,128,0);
  text(s2 + level.levelNumber, 100, 30);
    fill(255,128,0);
   text(s3 + quiver, 160, 30);
 }
    archer.display(); //draw the character
  for (Balloon b : balloons) {  // Draw and move red balloons
    b.display(); 
    b.move();   
  }
    if(level.levelNumber == 2){
     for (Balloon bY : Yballoons){  // Draw and move yellow balloons in level 2
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
    else if (level.levelNumber == 2){
     fill (0,0,20);
     textSize(40);
     text(s4, (width/2)-80 , height/2);
     // remove remaining yellow balloons and quiver if exist
     Yballoons.clear();  
    quiver = 0;
    arrows.clear();
    score.remainingArrows = 0;
    }}} 
}
 // end of draw

//Strt levels
void resetLevel() {
  balloons.clear(); 
  Yballoons.clear();  
       //initial  positions
  float startX = width - 30; 
  float startY = height - 40;
  if (level.levelNumber == 1) {
    // Level 1:  15 red balloons aligned next to each other
    for (int i = 0; i < 15; i++) {
      balloons.add(new Balloon(startX - i * 30, startY, false, 0)); // fill balloons
    }
  }
      //level2 : 3 yellow balloons and 15 red balloons with random positions
  else if (level.levelNumber == 2) {
          for (int i = 0; i < 15; i++) { // Red Balloons
     balloons.add(new Balloon (startX - i * 30 , random(height) , false , 0) ); 
  }
    for(int j = 0; j < 3; j++) {  // Yellow Balloons
         isYellow = j < 3;
        acceleration = j < 3 ? random(0.0009 , 0.001):0; // random acceleration for tricky balloons
        Yballoons.add(new Balloon (random(width-430, width-150) , random(height) , isYellow , acceleration) ); 
    }  
  }
}

// mouse Controls
void mouseMoved() {
  archer.update(mouseY);
}
void mousePressed() {  
  //Arrow reloading
  if(mouseButton == RIGHT && quiver > 0){
  arc = loadImage("imgs/chars/arrrcher_boy-01.png");
  arwPull.play();
  flag = true;
}
  // Arrow shooting
    if (mouseButton == LEFT && flag) {
  arc = loadImage("imgs/chars/arcccher_boy2-01.png");
    if (quiver > 0) {
      arrows.add(archer.shoot());
      arwSound.play();
      arwPull.stop();
      quiver--;
      score.remainingArrows = quiver;
      flag = false; // preventing random shooting
    }
  }
    
    // Try Again when you loose using Right click
  else if (mouseButton == RIGHT && quiver == 0) {
  if(level.levelNumber == 1 && !balloons.isEmpty()){
    quiver = 20;
    score.shotBalloons =0;
    resetLevel();
  }
else if(level.levelNumber == 2 && !balloons.isEmpty()){ // check for just the red balloons
    quiver = 20;
    score.shotBalloons =0;
    // resetting the same level with the previous level score 
    resetLevel();
  }
    }
}

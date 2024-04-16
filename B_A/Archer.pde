// Archer Class
class Archer {
  float y;
  
  Archer() {
    y = height / 2;
}
  void display() {
  //  fill(60,0,60);
    image(arc,0,y);
    //rect(50, y - 20, 20, 40);
  }
  
  void update(float varY) {
  y = varY; //  y = mouseY
   y = constrain(y,0,height-80); // gurantee that archer will not disappear from the screen 
 }
 
  Arrow shoot() { // return a new Arrow object  
    return new Arrow(90, y+55);
  }
}

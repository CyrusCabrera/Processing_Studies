PVector location = new PVector(0, 0);
PVector velocity = new PVector(1, 3);
int w = 15;
void setup() {
  size(100, 100);
  frameRate(5);  
  background(0);
}

void draw() {
  background(0);
  fill(255);
 
  location.x += velocity.x;
  location.y += velocity.y;

  if((location.x) > width || (location.x) < 0){
   velocity.x *= -1;
  }
  
  if((location.y) > height || (location.y) < 0){
   velocity.y *= -1;
  }
  
  ellipse(location.x, location.y, w, w);
}
/*
 Draws a crosshair centrered at x, y position. Color is grey tone.
 Crosshair has a gap an lenght l. 
*/
void setup() {
 size(320, 240);
 background(255);
}

void drawCrosshair(float x, float y, color c) {
  int gap = 3; // provide separation from center pixel
  int l = 7;   // lenght
  stroke(c);
  strokeWeight(0);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
  noStroke();
}

void draw() {
  stroke(0);
  // draw the target indicator
  color c = color(255, 0, 0);
  drawCrosshair(50, 50, 0);
  fill(155);
  rect(50, 50, 75, 100);
  
  noFill();
  drawCrosshair(150, 150, c);
  stroke(0);
  ellipse(150, 150, 200, 150);
  
}

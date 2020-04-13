void setup() {
 size(800, 480);
 background(255);
}
// draws crosshair see tools ... 
void drawCrosshair(int x, int y, int greyTone) {
  int gap = 3;
  int l = 7;
  stroke(greyTone);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
}

void drawZoog(int x, int y) {
 ellipseMode(CENTER);
 rectMode(CENTER);
 stroke(0);
 fill(150);
 rect(x, y, 20, 100);
 fill(255);
 ellipse(x, y-30, 60, 60);
 fill(0);
 ellipse(x-18, y-30, 16, 32);
 ellipse(x+18, y-30, 16, 32);
 stroke(0);
 //drawCrosshair(x-10, y+50, 0);
 line(x-10, y+50, x-20, y+60);
 //drawCrosshair(x+10, y+50, 0);
 line(x+10, y+50, x+20, y+60);
 // replace default values
 ellipseMode(CENTER);
 rectMode(CORNER);
 
}

void draw() {
  background(255);
  drawZoog(mouseX, mouseY);

}

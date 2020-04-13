/**
* Simply writes to screen
*/


void setup() {
  size(400, 300);
  // create a font with the third font available to the system:
  PFont myFont = createFont(PFont.list()[1], 14);
  textFont(myFont);
}

void draw() {
  background(0);
  text("Distance :", 10, 14);
  text("240", 100, 14);
  text(" cm", 128, 14);
}

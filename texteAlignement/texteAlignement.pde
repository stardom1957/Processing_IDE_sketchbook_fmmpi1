void setup() {
 size(800, 480); 
 background(0);
 stroke(153);
 textSize(11);
 println(" Ascent: " + textAscent());
 println("Descent: " + textDescent());
 textAlign(CENTER, BOTTOM);
 line(0, 30, width, 30);
 text("CENTER,BOTTOM", 50, 30);
 textAlign(CENTER, CENTER);
 line(0, 50, width, 50);
 text("CENTER,CENTER", 50, 50);
 textAlign(CENTER, TOP);
 line(0, 70, width, 70);
 text("CENTER,TOP", 50, 70);
}

void draw() {
}

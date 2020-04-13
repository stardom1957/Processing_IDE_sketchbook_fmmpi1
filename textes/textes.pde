int fontSize;
String texte1;
String texte2;
String texte3;
int x1;
int y1;
int x2;
int x3;
int y3;
float deltaY3;
float deltaY1;
float deltaY2;
int y2;
int wWidth;
int wHeight;

void setup() {
 // size(400, 200);
 //size(320, 240); //same as Nextion 2.8 in
 background(128);
 fill(255);
 stroke(0);
 size(800, 480); // same as Nextion 5 in
 x1 = 0;
 y1 = 23;
 fontSize = 20;
 textSize(fontSize);
 texte1 = "Marcher de Tokyo à Edo!";
 deltaY1 = y1 + fontSize  - (fontSize/4);  //compensate for font size 
 text(texte1, x1, deltaY1);
 //line(cw, 0, cw, fontSize);
 //this line will appear just under the text, like an underline
 line(x1, deltaY1 + 3, textWidth(texte1) + x1, deltaY1 + 3);
 
 // places texte2 inside a box
 fontSize = 24;
 textSize(fontSize);
 texte2 = "Tokyo";
 x2 = 22;
 y2 = 55;
 deltaY2 = y2 + fontSize  - (fontSize/4); 

 // draw the box
 strokeWeight(2);
 fill(128);
 //line(x2 - fontSize/2, deltaY2 - fontSize, x2 + textWidth(texte2) + fontSize/2, deltaY2 - fontSize);
 rect(x2 - fontSize/4, y2 - fontSize/4, textWidth(texte2) + fontSize/2, fontSize * 1.4);
// line(x2 - fontSize/2, deltaY2 - fontSize, x2 - fontSize/2, deltaY2 + fontSize/2 - 6);
// line(textWidth(texte2) + x2 + fontSize/2, deltaY2 - fontSize, x2 - fontSize/2, deltaY2 + fontSize/2 - 6);

 fill(255);
 text(texte2, x2, deltaY2);
 strokeWeight(1);
 
// draw the box first
 strokeWeight(2);
 fill(128);
 x3 = 55;
 y3 = 100;
 int boxW = 120;
 int boxH = 80;
 rect(x3, y3, boxW, boxH);

}

void draw() {
}

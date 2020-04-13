/* Montage géométrique
 A. ORIGINES ET CONVENTIONS DES ESPACES GÉOMÉTRIQUES UTILISÉS
     L'espace de Processing P a pour origine le coin supérieur gauche de la fenêtre de dessin, avec pour convention
     l'axe X positif vers la droite et l'axe Y positif vers le bas. L'espace géométrique O cartésien utilisé pour tous
     les calculs géométriques est centré au point O de coordonnées (0, 0) avec pour convention l'axe X positif vers
     la droite et l'axe Y positif vers le haut.
 
     L'origine de l'espace O est décallé de Ox, Oy dans l'espace P.
 
 B. TRANSFORMATIONS DE L'ESPACE GÉOMÉTRIQUE CARTÉSIEN VERS L'ESPACE DE PROCESSING
    Tous les calculs géométriques seront effectués dans l'espace cartésien O et les résultats
    seront ensuite transformés vers l'espace P pour le tracage.
    
    Un point de l'espace P est noté (xp, xp).
 
 C. This "Library" does not provide a replacement for any Pocessing drawing
    functions for primitives
*/

/* La classe Point définie un point dans les divers espaces géométriques.

   Les méthodes set permetent d'initialiser un point à partie de O ou de T, mais dans tous les
   cas, les point sont automatiquement transformés vers les autres espaces.
*/

class Point {
  float xp, yp; // x, y dans l'espace Processing (coin sup gauche fenêtre)
  float xo, yo; // x, y dans l'espace cartésien centré sur O (pour la géométrie)
  float xt, yt; // x, y dans l'espace cartésien centré sur T (pour la géométrie)

  // le constructeur ne fait rien
  Point () {}

  // initialisation d'un point dans l'espace O
  // et transformations vers P
  void seto(float x_o, float y_o) {
    xo = x_o;
    yo = y_o;
    xp = x_o + Ox;
    yp = Oy - y_o;
  }
}

// effectue une rotation de alpha° autour du point p dans O
// alpha > 0 est horaire
// alpha < 0 est anti-horaire
void rotationT(Point p, float alpha) {
  x = p.xo * cos(radians(alpha)) + p.yo * sin(radians(alpha));
  y = p.yo * cos(radians(alpha)) - p.xo * sin(radians(alpha));
}


// draws crosshair around a single pixel 
void drawCrosshair(float x, float y, color c) {
  int gap = 3; // provide separation from center pixel
  int l = 7;   // lenght
  strokeWeight(1);
  stroke(c);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
  noStroke();
}

// calcule la distance entre deux points dans l'espace P

float distanceP(Point p1, Point p2) {
  return dist(p1.xp, p1.yp, p2.xp, p2.yp);
}

// calcule la distance entre deux points dans l'espace O

float distanceO(Point p1, Point p2) {
  return dist(p1.xo, p1.yo, p2.xo, p2.yo);
}

// Définition des espaces géométriques
float Ox, Oy; // point O, aussi origine du système pour calcul géométrique
              // voir au début de setup()
float x, y; //pour les calculs

float centreFenetreX;
float centreFenetreY;

void setup() {
 size(800, 480);   // same as Nextion 5" and 7" HMI
 //size(320, 240); // same as Nextion 5" and 7" HMI
 
 centreFenetreX = width/2;
 centreFenetreY = height/2;

 // point O, origine du système
 Ox = centreFenetreX;
 Oy = centreFenetreY - 37;

}

//****************************************
//****************************************
void draw() {
  background(255);
  drawCrosshair(mouseX, mouseY, 0);
}

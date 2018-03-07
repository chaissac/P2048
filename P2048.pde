Grille jeu ;
int score ;
void setup() {
  size(400, 600);
  background(#BBADA0);
  jeu = new Grille(4);
  score = 0;
}
void draw() {
  jeu.trace(10, 10, 380);
}
void keyPressed() {
  switch(keyCode) {
  case RIGHT :
    score+=jeu.joue(0);
    break;
  case DOWN :
    score+=jeu.joue(1);
    break;
  case LEFT :
    score+=jeu.joue(2);
    break;
  case UP :
    score+=jeu.joue(3);
    break;
  }
}
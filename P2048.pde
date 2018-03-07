Grille jeu ;
int score, best ;
boolean over;
void setup() {
  size(400, 560);
  best = 999999;
  PFont font = createFont("Verdana Bold",36,true); //loadFont("dejavusansbold.vlw");
  textFont(font);
  init(4);
}
void init(int n) {
  jeu = new Grille(n);
  score = 0;
  over=false;
}
void draw() {
  background(#FAF8EF);
  noStroke();
  fill(jeu.maxi()>=2048?#F65E3B:#776E65);
  textSize(48);
  text("2048", 95, 40);
  fill(#BDAF9E);
  rect(190, 25, 90, 44, 2);
  rect(300, 25, 90, 44, 2);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(18);
  text(score, 235, 54);
  text(best, 345, 54);
  textSize(12);
  text("SCORE", 235, 34);
  text("BEST", 345, 34);
  fill(#776E65);
  text("Pour jouer, utilisez les touches fléchées.", 200, 96);
  text("Nouvelle partie : ", 70,538);
  noStroke();
  for (int i=3;i<10;i++) {
    fill(#776E65);
    rect(20+i*37,528,35,24,1);
    fill(255);
    text(i+"x"+i,38+i*37,538);
  }
  over = jeu.trace(10, 130, 380);

  if (over) {
    fill(#BDAF9E,220);
    noStroke();
    rect(10,130,380,380);
    fill(255);
    textSize(48);
    text("Game Over",200,320);
  }
}
void keyPressed() {
  switch(keyCode) {
  case RIGHT :
    score+=jeu.joue(0);
    break;
  case UP :
    score+=jeu.joue(1);
    break;
  case LEFT :
    score+=jeu.joue(2);
    break;
  case DOWN :
    score+=jeu.joue(3);
    break;
  default :
    println(keyCode);
  }
  if (score>best) best=score;
}
void mouseReleased() {
  if (mouseY>=528 && mouseY<=552) {
    int i=int((mouseX-20)/37);
    if (i>=3 && i<=9) init(i);
  }
}
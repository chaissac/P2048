class Grille {
  private int[] grille, backup ;
  private int taille;
  private color[] couleurs = {#CCC0B3, #EEE4DA, #EDE0C8, #F2B179, #F59563, #F67C5F, #F65E3B, #EDCF72, #EDCC61, #EDC850, #EDC53F, #EDC22E, #3E3933, #3E3933, #3E3933, #3E3933, #3E3933 };
  private int last;
  public Grille(int _taille) {
    taille = constrain(_taille, 3, 8);
    init();
  }
  public int joue(int d) {
    int sc = 0;
    println(d);
    rot(d);
    for (int j=0; j<taille; j++) {
      glisse(j);
      //sc+=combine(j);
      //glisse(j);
    }
    rot(-d);
    if (aChange()) {
      arrayCopy(grille, backup);
      ajoute();
    }
    return sc;
  }
  public void trace(float x, float y, float l) {
    float w = l/taille;
    strokeWeight(w/20);
    stroke(#BBADA0);
    PFont font = createFont("Arial Bold", 32);
    textFont(font);
    textAlign(CENTER, CENTER);
    for (int i=0; i<taille*taille; i++) {
      int v = lit(i);
      fill(couleurs[v]);
      rect(x+w*(i%taille), y+w*int(i/taille), w, w, w/10);
      if (v>0) {
        String txt = ""+int(pow(2, v));
        fill((v<3)?#605020:255);
        textSize(w*1.5);
        textSize(w*w/max(textWidth(txt), textAscent()+textDescent()));
        text(txt, x+w*(i%taille)+w/2, y+w*(int(i/taille))+w/2.2);
      }
    }
  }
  public void retour() {
    arrayCopy(backup, grille);
  }
  private void init() {
    grille = new int[taille*taille];
    backup = new int[taille*taille];
    ajoute(2);
  }
  private int lit(int x, int y) {
    return (x>=0 && x<taille && y>=0 && y<taille)?grille[x+taille*y]:0;
  }  
  private int lit(int i) {
    return (i>=0 && i<taille*taille)?grille[i]:0;
  }
  private boolean estPlein() {
    for (int g : grille) if (g==0) return false;
    return true;
  }
  private void ecrit(int x, int y, int n) {
    if (x>=0 && x<taille && y>=0 && y<taille) grille[x+taille*y]=n;
  }
  private void ecrit(int i, int n) {
    if (i>=0 && i<taille*taille) grille[i]=n;
  }
  private void glisse(int j) {
    for (int i=taille-1; i>0; i--) if (lit(i, j)==0) {
      for (int k=i; k>0; k--) 
        ecrit(k, j, lit(k-1, j));
      ecrit(0, j, 0);

    }
  }
  private int combine(int j) {
    int sc = 0;
    for (int i=taille-1; i>0; i--) 
      if (lit(i, j)==lit(i-1, j)) {
        ecrit(i, j, lit(i, j)+1);
        ecrit(i-1, j, 0);
        sc+=pow(2, lit(i, j));
      }
    return sc;
  }
  private void rot(int n) {
    for (int k=0; k<(n+4)%4; k++) rot();
  }
  private void rot() {
    int[] rot = new int[taille*taille];
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        rot[taille-1-j+taille*i] = lit(i, j);
      }
    }
    grille=rot;
  }
  private boolean aChange() {
    for (int i=0; i<taille*taille; i++) if (grille[i]!=backup[i]) return true;
    return false;
  }
  private void ajoute(int n) {
    for (int k=0; k<n; k++) ajoute();
  } 
  private void ajoute() {
    int i;
    if (!estPlein()) {
      do {
        i=int(random(taille*taille));
      } while (lit(i)!=0);
      ecrit(i, (random(1)>0.8)?2:1);
    }
  }
}
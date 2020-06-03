class TurretEye implements IDAnimation {
  float x;
  float y;
  float r;
  color clr;
  String name;
  int w;
  int h;
  public TurretEye(int w, int h, String turretName) {
    this.w = w;
    this.h = h;
    prep(turretName);
  }

  public void draw() {
    pushStyle();
    noStroke();
    ellipseMode(RADIUS);
    fill(clr);
    ellipse(x, y, r, r);
    popStyle();
  }
  

  void prep(String turretName) {
    this.name = turretName;
    if (name.equals("turretEye1")) {
      x = w/2;
      y = h/2;
      r = 75;
      clr = #B73751;
    }
  }

  String getName() {
    return this.name;
  }
  
  String getLanguage(){return "";}
  void setLanguage(String l){}
  
  void update(float time, float mintime, float maxtime, float min, float max) {

    if (name.equals("turretEye1")) {
      /*
    von 3100 bis 3630     auge von 0 auf 200 radius  XX
       von 4200 bis 4700, 125 Abstand     aus, an, aus, an
       von 6750 bis 7100     nach unten rechts
       von 9000 bis 9400     zurück
       von 11.300 bis 11.600 nach links
       von 14.000 bis 14.400 nach oben
       von 17.000 bis 17.300 mitte
       von 19.000 bis 20.000 von 200 auf 0 radius
       */
      if (time < 3100) {
        this.r = 0;
      }
      if (time >= 3100 && time < 3630) {
        this.r = map(time, 3100, 3630, 0, 75);
      }
      if (time >= 4200 && time < 4325) {
        this.r = map(time, 4200, 4325, 75, 0);
      }
      if (time >= 4325 && time < 4450) {
        this.r = map(time, 4325, 4450, 0, 75);
      }
      if (time >= 4450 && time < 4575) {
        this.r = map(time, 4450, 4575, 75, 0);
      }
      if (time >= 4575 && time < 4700) {
        this.r = map(time, 4575, 4700, 0, 75);
      }
      if (time >= 6750 && time < 7100) {
        this.x = map(time, 6750, 7100, w/2, w/2+50);
        this.y = map(time, 6750, 7100, h/2, h/2+20);
      }
      if (time >= 9000 && time < 9400) {
        this.x = map(time, 9000, 9400, w/2+50, w/2);
        this.y = map(time, 9000, 9400, h/2+20, h/2);
      }
      if (time >= 11300 && time < 11600) {
        this.x = map(time, 11300, 11600, w/2, w/2-75);
      }
      if (time >= 14000 && time < 14400) {
        this.y = map(time, 14000, 14400, h/2, h/2-20);
      }
      if (time >= 17000 && time < 17300) {
        this.x = map(time, 17000, 17300, w/2-75, w/2);
        this.y = map(time, 17000, 17300, h/2-20, h/2);
      }
      if (time >= 19000 && time < 20000) {
        this.r = map(time, 19000, 20000, 75, 0);
      }
    }
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getW() {
    return w;
  }

  public float getH() {
    return h;
  }
}

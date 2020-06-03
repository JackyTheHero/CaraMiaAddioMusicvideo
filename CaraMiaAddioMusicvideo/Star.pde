class Star implements Animation  {
  float x;
  float y;
  float radius;
  color clr;
  float destX;
  float destY;
  float vx;
  float vy;

  public Star(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.destX = 0;
    this.destY = 0;
    vx = 0;
    vy = 0;
  }

  public void draw() {
    pushStyle();
    noStroke();
    ellipseMode(RADIUS);
    fill(clr);
    ellipse(x, y, radius, radius);
    popStyle();
  }
  
  // implementieren Interface
  void update(float time, float mintime, float maxtime, float min, float max) {
    //this.radius = map(time, mintime, maxtime, min, max);
  }
  
  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getRadius() {
    return radius;
  }

  public void setColor(color colorToSet) {
    this.clr = colorToSet;
  }
}

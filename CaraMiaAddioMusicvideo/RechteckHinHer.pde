
class RechteckHinHer implements Animation {
  float x, y, w, h;

  public RechteckHinHer(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void draw() {
    pushStyle();
    rectMode(CENTER);
    fill(#C95FC7);
    noStroke();
    rect(x, y, w, h);
    popStyle();
  }

  public void update(float time, float mintime, float maxtime, float min, float max) {
    if (time < maxtime/4) {
      this.w = map(time, mintime, maxtime/4, 0, max(min, max)/3);
    } else if (time < maxtime/2) {
      this.w = map(time, maxtime/4, maxtime/2, max(min, max)/3, 0);
    } else if (time < (maxtime/2 + maxtime/4)) {
      this.w = map(time, maxtime/2, maxtime/2+maxtime/4, 0, max(min, max)/3);
    } else {
      this.w = map(time, maxtime/2+maxtime/4, maxtime, max(min, max)/3, 0);
    }

    if (time < maxtime/2) {
      this.x = map(time, mintime, maxtime/2, min, max);
    } else {
      this.x = map(time, maxtime/2, maxtime, max, min);
    }
  }

  public void fullUpdate(float time, float mintime, float maxtime, float min, float max) {
    if (time < maxtime/4) {
      this.w = map(time, mintime, maxtime/4, 0, max(min, max)/2);
    } else if (time < maxtime/2) {
      this.w = map(time, maxtime/4, maxtime/2, max(min, max)/2, 0);
    } else if (time < (maxtime/2 + maxtime/4)) {
      this.w = map(time, maxtime/2, maxtime/2+maxtime/4, 0, max(min, max)/2);
    } else {
      this.w = map(time, maxtime/2+maxtime/4, maxtime, max(min, max)/2, 0);
    }

    if (time < maxtime/2) {
      this.x = map(time, mintime, maxtime/2, min, max);
    } else {
      this.x = map(time, maxtime/2, maxtime, max, min);
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

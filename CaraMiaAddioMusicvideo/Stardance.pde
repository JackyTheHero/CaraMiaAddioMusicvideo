public class Stardance implements Animation {
  float x;
  float y;
  Star[] stars;
  int w;
  int h;
  int whoFirst; // 0 --> destX is made first  , 1 --> destY
  int posOrNeg; // 0 --> second dest is going towards -30 , 1 --> towards upper barrier + 30

  public Stardance(int w, int h) {
    this.h = h;
    this.w = w;
    this.stars = new Star[50];
    this.prep();
    this.x = w/2;
    this.y = h/2;
  }

  void prep() {
    for (int i = 0; i < stars.length; i++) {
      this.stars[i] = new Star(w/2, h/2, 0);

      //setting random colours
      this.stars[i].setColor(lerpColor(#B1FAF6, #FFFED1, random(0, 1)));

      //setting velocity
      this.stars[i].vx = random(0, 100);
      this.stars[i].vy = random(0, 70);

      //setting end points (always out of sight)
      this.whoFirst = (int)random(0, 2);
      this.posOrNeg = (int)random(0, 2);

      if (whoFirst == 0) {
        this.stars[i].destX = random(-30, w+30);
        if (posOrNeg == 0) {
          this.stars[i].destY = -30;
        } else {
          this.stars[i].destY = h+30;
        }
      } else {
        this.stars[i].destY = random(-30, h+30);
        if (posOrNeg == 0) {
          this.stars[i].destX = -30;
        } else {
          this.stars[i].destX = w+30;
        }
      }
    }
  }

  void update(float time, float mintime, float maxtime, float min, float max) {
    for (int i = 0; i < stars.length; i++) {
      stars[i].radius = map(time, mintime, maxtime, 0, 10);
      if (stars[i].destX < w/2) {
        stars[i].x = map(time, mintime, maxtime, w/2, stars[i].destX) - stars[i].vx;
      } else {
        stars[i].x = map(time, mintime, maxtime, w/2, stars[i].destX) + stars[i].vx;
      }

      if (stars[i].destY < w/2) {
        stars[i].y = map(time, mintime, maxtime, h/2, stars[i].destY) - stars[i].vy;
      } else {
        stars[i].y = map(time, mintime, maxtime, h/2, stars[i].destY) + stars[i].vy;
      }
    }
  }

  void draw() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].draw();
    }
  }
}

public class PulsatingCircles implements MultiAnimations {
  //private Star k0, k1, k2, k3, k4, k5;
  //private Timer t0, t1, t2, t3, t4, t5;
  private int anzahl;
  ArrayList<Star> circles = new ArrayList<Star>();
  ArrayList<Timer> timers = new ArrayList<Timer>();

  public PulsatingCircles(float max, float canvasW, float canvasH, int anzahl) {
    
    this.anzahl = anzahl;

    /* k0 = new Star(random(canvasW/15,canvasW-canvasW/15), random(canvasH/15,canvasH-canvasH/15), random(30, 100));
     k0.setColor(#C95FC7);
     
     k1 = new Star(random(canvasW/15,canvasW-canvasW/15), random(canvasH/15,canvasH-canvasH/15), random(30, 100));
     k1.setColor(#C95FC7); */

    for (int i = 0; i < anzahl; i++) {
      circles.add(new Star(random(canvasW/15, canvasW-canvasW/15), random(canvasH/15, canvasH-canvasH/15), random(30, 100)));
      circles.get(i).setColor(#B73751);
    }
    for (int i = 0; i < anzahl; i++) {
      timers.add(new Timer(max, circles.get(i), 30, 100));
    }
    //t0 = new Timer(max, k0, 30, 100);
    //t1 = new Timer(max, k1, 30, 100);
  }


  void start() {
    for (int i = 0; i < anzahl; i++) {
      timers.get(i).start();
    }
  }
  void reset() {
        for (int i = 0; i < anzahl; i++) {
      timers.get(i).reset();
    }
  }
  void stop() {
        for (int i = 0; i < anzahl; i++) {
      timers.get(i).stop();
    }
  }
  void pause() {
        for (int i = 0; i < anzahl; i++) {
      timers.get(i).pause();
    }
  }
  void tick() {
        for (int i = 0; i < anzahl; i++) {
      timers.get(i).tick();
    }
  }
  void drawAll() {
        for (int i = 0; i < anzahl; i++) {
      circles.get(i).draw();
    }
  }
  boolean isRunning() {
    return timers.get(0).isRunning();
  }
  boolean hasStarted() {
    return timers.get(0).hasStarted();
  }
}

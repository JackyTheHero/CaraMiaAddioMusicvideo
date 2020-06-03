
class FullscreenRechteckHinHer implements MultiAnimations{
  private RechteckHinHer r0, r1, r2, r3, r4, r5;
  private Timer t0, t1, t2, t3, t4, t5;
  private float abstand;

  public FullscreenRechteckHinHer(float max, float canvasW, float canvasH) {
    System.out.println("fRHH erstellt");
    abstand = canvasH/5;
    this.r0 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);
    canvasH -= abstand;
    this.r1 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);
    canvasH -= abstand;
    this.r2 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);
    canvasH -= abstand;
    this.r3 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);
    canvasH -= abstand;
    this.r4 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);
    canvasH -= abstand;
    this.r5 = new RechteckHinHer(canvasW/2, canvasH, 30, 20);

    this.t0 = new Timer(max, r0, canvasW, 0);
    this.t1 = new Timer(max, r1, 0, canvasW);
    this.t2 = new Timer(max, r2, canvasW, 0);
    this.t3 = new Timer(max, r3, 0, canvasW);
    this.t4 = new Timer(max, r4, canvasW, 0);
    this.t5 = new Timer(max, r5, 0, canvasW);
  }

  public void start() {
    t0.start();
    t1.start();
    t2.start();
    t3.start();
    t4.start();
    t5.start();
  }
  

  public void reset() {
    t0.reset();
    t1.reset();
    t2.reset();
    t3.reset();
    t4.reset();
    t5.reset();
  }

  public void stop() {
    t0.stop();
    t1.stop();
    t2.stop();
    t3.stop();
    t4.stop();
    t5.stop();
  }
 
    public void pause() {
    t0.pause();
    t1.pause();
    t2.pause();
    t3.pause();
    t4.pause();
    t5.pause();
  }

  public void tick() {
    t0.tick();
    t1.tick();
    t2.tick();
    t3.tick();
    t4.tick();
    t5.tick();
  }

  void drawAll() {
    r0.draw();
    r1.draw();
    r2.draw();
    r3.draw();
    r4.draw();
    r5.draw();
  }

  boolean isRunning() {
    return t0.isRunning();
  }
  
  boolean hasStarted() {
    return t0.hasStarted();
  }
}

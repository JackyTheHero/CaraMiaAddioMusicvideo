interface MultiAnimations {
  void start();
  void reset();
  void stop();
  void pause();
  void tick();
  void drawAll();
  boolean isRunning();
  boolean hasStarted();
}

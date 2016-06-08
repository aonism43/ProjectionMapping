class Point {

  private float x;
  private float y;

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public float get_X() {
    return this.x;
  }

  public float get_Y() {
    return this.y;
  }

  public void set_X(float x) {
    this.x = x;
  }

  public void set_Y(float y) {
    this.y = y;
  }

  public void set_Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
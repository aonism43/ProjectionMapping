class Object {

  private Point left_top;
  private Point right_top;
  private Point left_bottom;
  private Point right_bottom;

  private Point p1;
  private Point p2;
  private Point p3;
  private Point p4;

  private int count;
  private int n;

  public Object(Point p1, Point p2, Point p3, Point p4, int n) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    this.n=n+21;

    this.count = 0;

    this.left_top = p1;
    this.right_top = p2;
    this.left_bottom = new Point((int)(p1.getX() + (p3.getX() - p1.getX()) * square_param), (int)(p1.getY() + (p3.getY() - p1.getY()) * square_param));
    this.right_bottom = new Point((int)(p2.getX() + (p4.getX() - p2.getX()) * square_param), (int)(p2.getY() + (p4.getY() - p2.getY()) * square_param));
  }

  public void fall() {
    this.left_top = new Point((int)lerp(p1.getX(), p3.getX(), count / 100.0), (int)lerp(p1.getY(), p3.getY(), count / 100.0));
    this.right_top = new Point((int)lerp(p2.getX(), p4.getX(), count / 100.0), (int)lerp(p2.getY(), p4.getY(), count / 100.0));
    this.left_bottom = new Point((int)(left_top.getX() + (p3.getX() - p1.getX()) * square_param), (int)(left_top.getY() + (p3.getY() - p1.getY()) * square_param));
    this.right_bottom = new Point((int)(right_top.getX() + (p4.getX() - p2.getX()) * square_param), (int)(right_top.getY() + (p4.getY() - p2.getY()) * square_param));
    this.count++;
  }

  public Point getLeftTop() {
    return this.left_top;
  }

  public Point getRightTop() {
    return this.right_top;
  }

  public Point getLeftBottom() {
    return this.left_bottom;
  }

  public Point getRightBottom() {
    return this.right_bottom;
  }

  public int getCount() {
    return this.count;
  }
  
  public int getN(){
    return this.n;
  }
}
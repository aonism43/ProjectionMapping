class Object {
  private Point[] p = new Point[4];
  private Quadrangle quad;
  
  private Point left_top;
  private Point right_top;
  private Point left_bottom;
  private Point right_bottom;

  private int count;
  private int note_num;

  public Object(Quadrangle q, int h) {
    this.quad = q;
    
    for(int i=0; i<4; i++){
      this.p[i] = q.get_apex(i);
    }

    this.note_num  = h+21;

    this.count = 0;

    this.left_top  = p[0];
    this.right_top = p[1];
    this.left_bottom  = new Point(p[0].get_X() + (this.quad.get_diff_x(3)) * square_param, p[0].get_Y() + (this.quad.get_diff_y(0)) * square_param);
    this.right_bottom = new Point(p[1].get_X() + (this.quad.get_diff_x(1)) * square_param, p[1].get_Y() + (this.quad.get_diff_y(1)) * square_param);
  }

  public void fall() {
    this.left_top     = new Point(lerp(p[0].get_X(), p[2].get_X(), this.count / 100.0), lerp(p[0].get_Y(), p[2].get_Y(), this.count / 100.0));
    this.right_top    = new Point(lerp(p[1].get_X(), p[3].get_X(), this.count / 100.0), lerp(p[1].get_Y(), p[3].get_Y(), this.count / 100.0));
    this.left_bottom  = new Point(left_top.get_X()  + this.quad.get_diff_x(3) * square_param, left_top.get_Y()  + this.quad.get_diff_y(3) * square_param);
    this.right_bottom = new Point(right_top.get_X() + this.quad.get_diff_x(1) * square_param, right_top.get_Y() + this.quad.get_diff_y(1) * square_param);
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

  public int get_count() {
    return this.count;
  }
  
  public int get_note_num(){
    return this.note_num;
  }
}
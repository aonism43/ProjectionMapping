class Quadrangle extends Polygon{
  private Point[] apex;
  private float[] side_length;
  private float[] diff_x; 
  private float[] diff_y; 
  
  Quadrangle(int n){
    super(n);
    apex = new Point[n];
    side_length = new float[n];
    diff_x = new float[n];
    diff_y = new float[n];
    
    for(int i=0; i<n; i++){
      side_length[i] = util.mydist(apex[i], apex[util.limit_figure(i+1, n)]);
      diff_x[i] = apex[i].get_X() - apex[util.limit_figure(i+1, n)].get_X();
      diff_y[i] = apex[i].get_Y() - apex[util.limit_figure(i+1, n)].get_Y();
    }
  }
  
  public void set_left_top(Point p){
    this.apex[0] = p;
  }
  
  public void set_right_top(Point p){
    this.apex[1] = p;
  }
  
  public void set_right_bottom(Point p){
    this.apex[2] = p;
  }
  
  public void set_left_bottom(Point p){
    this.apex[3] = p;
  }
  
  
  public void Shape(Movie mov){
    beginShape();
      texture(mov);
      util.myvertex(this.apex[0], 0        , 0         );
      util.myvertex(this.apex[1], mov.width, 0         );
      util.myvertex(this.apex[2], mov.width, mov.height);
      util.myvertex(this.apex[3], 0        , mov.height);
    endShape(CLOSE);
  }
  
  public void Shape(PImage img){
    beginShape();
      texture(img);
      util.myvertex(this.apex[0], 0        , 0         );
      util.myvertex(this.apex[1], img.width, 0         );
      util.myvertex(this.apex[2], img.width, img.height);
      util.myvertex(this.apex[3], 0        , img.height);
    endShape(CLOSE);
  }
}
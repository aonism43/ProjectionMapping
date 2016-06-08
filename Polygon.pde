class Polygon{
  private Point[] apex;
  private float[] side_length;
  private float[] diff_x; 
  private float[] diff_y; 
  
  Polygon(int n){
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
  
  
  public Point[] get_apex(){
    return this.apex;
  }
  
  public Point get_apex(int n){
    return this.apex[n];
  }
  
  public int get_apex_length(){
    return this.apex.length;
  }
  
  public float get_side_length(int n){
    return this.side_length[n];
  }
  
  public float get_diff_x(int n){
    return this.diff_x[n];
  }
  
  public float get_diff_y(int n){
    return this.diff_y[n];
  }
  
  
  public void set_all_apex(Point[] p){
    for(int i=0; i<this.apex.length; i++){
      this.apex[i] = p[i];
    }
  }
  
  public void set_vertex(Point p, int n){
    this.apex[n] = p;
  }
}
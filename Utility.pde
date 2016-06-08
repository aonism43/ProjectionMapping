class Utility{
  public float mydist(Point p1, Point p2){
    return dist(p1.get_X(), p1.get_Y(), p2.get_X(), p2.get_Y());
  }
  
  public int limit_figure(int n, int upper_limit){
    if (n < upper_limit) return n;
      else return n-upper_limit;
  }
  
  public void myvertex(Point p, int w, int h){
    vertex(p.get_X(), p.get_Y(), w, h);
  }
  
  
  public void loading_txt(String name, Polygon poly) {
    try {
      int count = 0;
      String s = null;
      BufferedReader r = createReader("pointInfo/" + name + "Point.txt");

      while ((s = r.readLine()) != null) {
        String[] split = splitTokens(s, ",");
        
        if (count != 0) {
          poly.get_apex(count).set_X(int(split[0]));
          poly.get_apex(count).set_Y(int(split[1]));
        }
        
        count++;
        }
      } catch(IOException e) {
        println("ばーか");
    }
  }
  
  public void loading_txt(String name, Quadrangle quad) {
    try {
      int count = 0;
      String s = null;
      BufferedReader r = createReader("pointInfo/" + name + "Point.txt");

      while ((s = r.readLine()) != null) {
        String[] split = splitTokens(s, ",");
        
        if (count != 0) {
          quad.get_apex(count).set_X(int(split[0]));
          quad.get_apex(count).set_Y(int(split[1]));
        }
        
        count++;
        }
      } catch(IOException e) {
        println("ばーか");
    }
  }
  
  public void writing_txt(String name, Polygon poly) {
    String[] w = new String[poly.get_apex_length()];

    for (int i=0; i<poly.get_apex_length(); i++) 
      w[i] = poly.get_apex(i).get_X()+","+poly.get_apex(i).get_Y();

    saveStrings("pointInfo/"+name+"Point.txt", w);
  }
  
  public void writing_txt(String name, Quadrangle quad) {
    String[] w = new String[quad.get_apex_length()];

    for (int i=0; i<quad.get_apex_length(); i++) 
      w[i] = quad.get_apex(i).get_X()+","+quad.get_apex(i).get_Y();

    saveStrings("pointInfo/"+name+"Point.txt", w);
  }
}
Movie mov = new Movie(this, "snow/snow400n.mp4");

class Snow {
  private ArrayList<Object> crystal = new ArrayList<Object>();//描画する結晶の頂点
  private PImage[] img = new PImage[109];//結晶画像
  
  private Quadrangle quad = new Quadrangle(4);

  Snow() {
    mov.loop();

    for (int i=21; i<=108; i++) 
      this.img[i] = loadImage("snow/snow"+i+".png");
      
    util.loading_txt("Snow", this.quad);
  }
  
  public Point get_polygon(int n){
    return this.quad.get_apex(n);
  }

  public void draw() {
    //---降雪動画の描画---//
    tint(255, 255, 255, 255);
    quad.Shape(mov);


    for (int i = 0; i < crystal.size(); i++) {
      //---結晶の描画---//
      beginShape();
      texture(img[crystal.get(i).get_note_num()]);
      util.myvertex(crystal.get(i).getLeftTop()    , 0                                       , 0                                        );
      util.myvertex(crystal.get(i).getRightTop()   , img[crystal.get(i).get_note_num()].width, 0                                        );
      util.myvertex(crystal.get(i).getRightBottom(), img[crystal.get(i).get_note_num()].width, img[crystal.get(i).get_note_num()].height);
      util.myvertex(crystal.get(i).getLeftBottom() , 0                                       , img[crystal.get(i).get_note_num()].height);
      endShape();

      crystal.get(i).fall();

      if (crystal.get(i).get_count() > 100) {
        int n = crystal.get(i).get_note_num()-21;
        isKeying[n%12][n/12]=false;
        simult_keying_count--;

        crystal.remove(i);
        i--;
      }
    }
  }

  private void create_crystal(int n) {  
    Point p1 = new Point(this.quad.get_apex(0).get_X() - this.quad.get_diff_x(0) * n / 88, this.quad.get_apex(0).get_Y() - this.quad.get_diff_y(0) * n / 88);
    Point p2 = new Point(p1.get_X() + this.quad.get_diff_x(0) * 80 / 1366.0              , p1.get_Y() + this.quad.get_diff_y(0) * 80 / 1366.0              );
    Point p3 = new Point(this.quad.get_apex(2).get_X() - this.quad.get_diff_x(2) * n / 88, this.quad.get_apex(2).get_Y() - this.quad.get_diff_y(2) * n / 88);
    Point p4 = new Point(p3.get_X() + this.quad.get_diff_x(2) * 80 / 1366.0              , p3.get_Y() + this.quad.get_diff_y(2) * 80 / 1366.0              );
    
    Quadrangle quad = new Quadrangle(4);
    quad.set_all_apex(new Point[]{p1, p2, p3, p4});
    
    crystal.add(new Object(quad, n));
  }
}
Movie snowfall;//降雪動画
ArrayList<Object> crystals = new ArrayList<Object>();//描画する結晶の頂点
PImage[] snow=new PImage[109];//結晶画像

void setup_Snow() {
  snowfall=new Movie(this, "snow/snow400n.mp4");
  snowfall.loop();

  for (int i=21; i<=108; i++) 
    snow[i] = loadImage("snow/snow"+i+".png");
}

void draw_Snow() {
  //---降雪動画の描画---//
  tint(255, 255, 255, 255);
  beginShape();
  texture(snowfall);
  vertex(snowfall_p1.getX(), snowfall_p1.getY(), 0, 0);
  vertex(snowfall_p2.getX(), snowfall_p2.getY(), snowfall.width, 0);
  vertex(snowfall_p4.getX(), snowfall_p4.getY(), snowfall.width, snowfall.height);
  vertex(snowfall_p3.getX(), snowfall_p3.getY(), 0, snowfall.height);
  endShape(CLOSE);

  for (int i = 0; i < crystals.size(); i++) {
    //---結晶の描画---//
    beginShape();
    texture(snow[crystals.get(i).getN()]);
    vertex(crystals.get(i).getLeftTop().getX(), crystals.get(i).getLeftTop().getY(), 0, 0);
    vertex(crystals.get(i).getRightTop().getX(), crystals.get(i).getRightTop().getY(), snow[crystals.get(i).getN()].width, 0);
    vertex(crystals.get(i).getRightBottom().getX(), crystals.get(i).getRightBottom().getY(), snow[crystals.get(i).getN()].width, snow[crystals.get(i).getN()].height);
    vertex(crystals.get(i).getLeftBottom().getX(), crystals.get(i).getLeftBottom().getY(), 0, snow[crystals.get(i).getN()].height);
    endShape();

    crystals.get(i).fall();

    if (crystals.get(i).getCount() > 100) {
      int n=crystals.get(i).getN()-21;
      isKeying[n%12][n/12]=false;
      simult_keying_count--;

      crystals.remove(i);
      i--;
    }
  }
}

void drawCrystal(int n) {
  Point p5 = new Point(snowfall_p1.getX() + (snowfall_p2.getX() - snowfall_p1.getX()) * n / 88, snowfall_p1.getY() + (snowfall_p2.getY() - snowfall_p1.getY()) * n / 88);
  Point p6 = new Point(p5.getX() + (int)((float)((snowfall_p2.getX() - snowfall_p1.getX()) * 80) / 1366.0), p5.getY() + (int)((float)((snowfall_p2.getY() - snowfall_p1.getY()) * 80) / 1366.0));
  Point p7 = new Point(snowfall_p3.getX() + (snowfall_p4.getX() - snowfall_p3.getX()) * n / 88, snowfall_p3.getY() + (snowfall_p4.getY() - snowfall_p3.getY()) * n / 88);
  Point p8 = new Point(p7.getX() + (int)((float)((snowfall_p4.getX() - snowfall_p3.getX()) * 80) / 1366.0), p7.getY() + (int)((float)((snowfall_p4.getY() - snowfall_p3.getY()) * 80) / 1366.0));

  crystals.add(new Object(p5, p6, p7, p8, n));
}
void reading_txt(String name, Point[] p) {
  try {
    int c=0;
    String s=null;
    BufferedReader r=createReader("pointInfo/"+name+"Point.txt");

    while ((s=r.readLine())!=null) {
      String[] split=splitTokens(s, ",");
      if (c!=0) {
        p[c].setX(int(split[0]));
        p[c].setY(int(split[1]));
      }
      c++;
    }
  }
  catch(IOException e) {
  }
}

void writing_txt(String name, Point[] p) {
  String[] w=new String[p.length];

  for (int i=0; i<p.length; i++) 
    w[i]=p[i].getX()+","+p[i].getY();

  saveStrings("pointInfo/"+name+"Point.txt", w);
}

void reading_all_txt() {
  reading_txt("snowfall", snowfall_vertex);
  reading_txt("chara", chara_vertex);
  reading_txt("telop", telop_vertex);
  reading_txt("wancolle", wancolle_vertex);
}

void writing_all_txt() {
  writing_txt("snowfall", snowfall_vertex);
  writing_txt("chara", chara_vertex);
  writing_txt("telop", telop_vertex);
  writing_txt("wancolle", wancolle_vertex);
}
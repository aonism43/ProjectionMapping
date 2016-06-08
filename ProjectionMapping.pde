import processing.video.*;
import processing.opengl.*;
import rwmidi.*;

Utility util = new Utility();

//---DebugMode---//
boolean is_debugmode = true;

//---Constant---//
final int SQUARESIDE = 40;//結晶の一辺の長さ

//---Snow---//
float square_param;//正方形にするための比率
int simult_keying_count=0;//同時発音数

BeckonCharacter beckon = new BeckonCharacter();
GrowUpCharacter growup = new GrowUpCharacter();
MIDI midi              = new MIDI();
Snow snow              = new Snow();
Telop telop            = new Telop();

Polygon wancolle_polygon = new Polygon(14);

//---Translate---//
int point_selected_area = -1;//どの範囲の画像が選択されているか
int point_selected_v = -1;//どの頂点が選択されているか
boolean save_state = false;//今の頂点の座標は保存してあるか

void setup() {
  fullScreen(P3D);

  setup_WanColle();

  square_param = (SQUARESIDE/util.mydist(snow.get_polygon(0), snow.get_polygon(2)));
}

void draw() {
  background(0);
  noStroke();

  if (is_debugmode) {
    fill(255);
    stroke(#ffff00);

    if (save_state){
      text("save complete.", 5, height-5);
    }

    //text(keyingCount, 0, 10);
    text(simult_keying_count, 0, 30);
    text(count_true_chord+"/180", 0, 50);

    for (int i=0; i<12; i++) 
      for (int j=0; j<8; j++) 
        if (isKeying[i][j]) 
          text(midi.get_scale_name(i+j*12+21), i*50, (j+21)*10);
  }

  snow.draw();
  beckon.draw();
  growup.draw();
  telop.draw();
  draw_WanColle();

  Translate(); //マウスによる頂点操作
  //GatheringMIDI();//打鍵情報の収集
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  switch(key) {
  case'a':
    h=60;
    drawCrystal(h-21);
    println(true);
    break;

  case's':
    writing_all_txt();
    save_state=true;
    break;
  }
}
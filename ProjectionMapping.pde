import processing.video.*;
import processing.opengl.*;
import rwmidi.*;

//---DebugMode---//
boolean debugMode=true;
boolean isUsingPiano=false;

//---Constant---//
final int SNOWFALL_VERTEX=4;//降雪動画の頂点数
final int CHARACTER_VERTEX=4;//キャラ画像の頂点数
final int TELOP_VERTEX=14;//テロップ画像の頂点数
final int WANCOLLE_VERTEX=14;//わんこれの頂点数

final int SQUARESIDE=40;//結晶の一辺の長さ
final int CHARACTER_NUM=10;//キャラの成長段階数
final int GROATH_SPEED=100;//
final int TELOP_NUM=8;//テロップの種類
final int NG_TELOP_NUM=3;//NGテロップの種類
final int telopSpeed=1;//テロップが動く間隔｜(frameCount%telopspeed==0)
final int TELOP_MOVE=-2400;//テロップの初期位置からのずれ
final int TELOP_SPEED=5;//テロップの流れる速さ

//---Snow---//
float square_param;//正方形にするための比率
int simult_keying_count=0;//同時発音数

Point snowfall_p0 = new Point(0, 0);
Point snowfall_p1 = new Point(0, 0);
Point snowfall_p2 = new Point(0, 0);
Point snowfall_p3 = new Point(0, 0);
Point snowfall_p4 = new Point(0, 0);
Point[] snowfall_vertex={
  snowfall_p0, snowfall_p1, snowfall_p2, snowfall_p3, snowfall_p4
};

//---Character---//
Point chara_p0 = new Point(0, 0);
Point chara_p1 = new Point(0, 0);
Point chara_p2 = new Point(0, 0);
Point chara_p3 = new Point(0, 0);
Point chara_p4 = new Point(0, 0);
Point chara_p5 = new Point(0, 0);
Point chara_p6 = new Point(0, 0);
Point chara_p7 = new Point(0, 0);
Point chara_p8 = new Point(0, 0);
Point[] chara_vertex={
  chara_p0, chara_p1, chara_p2, chara_p3, chara_p4, 
  chara_p5, chara_p6, chara_p7, chara_p8
};
//---Telop---//
Point telop_p0 = new Point(0, 0);
Point telop_p1 = new Point(0, 0);
Point telop_p2 = new Point(0, 0);
Point telop_p3 = new Point(0, 0);
Point telop_p4 = new Point(0, 0);
Point telop_p5 = new Point(0, 0);
Point telop_p6 = new Point(0, 0);
Point telop_p7 = new Point(0, 0);
Point telop_p8 = new Point(0, 0);
Point telop_p9 = new Point(0, 0);
Point telop_p10 = new Point(0, 0);
Point telop_p11 = new Point(0, 0);
Point telop_p12 = new Point(0, 0);
Point telop_p13 = new Point(0, 0);
Point telop_p14 = new Point(0, 0);
Point[] telop_vertex={
  telop_p0, telop_p1, telop_p2, telop_p3, telop_p4, 
  telop_p5, telop_p6, telop_p7, telop_p8, telop_p9, 
  telop_p10, telop_p11, telop_p12, telop_p13, telop_p14
};

//---WanColle---//
Point wancolle_p0 = new Point(0, 0);
Point wancolle_p1 = new Point(0, 0);
Point wancolle_p2 = new Point(0, 0);
Point wancolle_p3 = new Point(0, 0);
Point wancolle_p4 = new Point(0, 0);
Point wancolle_p5 = new Point(0, 0);
Point wancolle_p6 = new Point(0, 0);
Point wancolle_p7 = new Point(0, 0);
Point wancolle_p8 = new Point(0, 0);
Point wancolle_p9 = new Point(0, 0);
Point wancolle_p10 = new Point(0, 0);
Point wancolle_p11 = new Point(0, 0);
Point wancolle_p12 = new Point(0, 0);
Point wancolle_p13 = new Point(0, 0);
Point wancolle_p14 = new Point(0, 0);
Point[] wancolle_vertex={
  wancolle_p0, wancolle_p1, wancolle_p2, wancolle_p3, wancolle_p4, 
  wancolle_p5, wancolle_p6, wancolle_p7, wancolle_p8, wancolle_p9, 
  wancolle_p10, wancolle_p11, wancolle_p12, wancolle_p13, wancolle_p14
};

//---Translate---//
int point_selected_area=-1;//どの範囲の画像が選択されているか
int point_selected_v=-1;//どの頂点が選択されているか
boolean save_state=false;//今の頂点の座標は保存してあるか

//---GatheringMIDI---//
int keyingCount=0;//打鍵回数
boolean isSilent=true;//無音かどうか
boolean isWriting_start_time=false;//無音時間の開始時刻を代入したかどうか

//---Other---//
Point[][] all_vertex={//全ての頂点｜Point[area][vertex]
  snowfall_vertex, chara_vertex, telop_vertex, wancolle_vertex
};

String[] scaleName={//ノート番号から音名を取得する配列
  "", "", "", "", "", "", "", "", "", "", 
  "", "", "", "", "", "", "", "", "", "", 
  "", "A0", "A#0", "B0", 
  "C0", "C#0", "D0", "D#0", "E0", "F0", "F#0", "G0", "G#0", "A0", "A#0", "B0", 
  "C1", "C#1", "D1", "D#1", "E1", "F1", "F#1", "G1", "G#1", "A1", "A#1", "B1", 
  "C2", "C#2", "D2", "D#2", "E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", 
  "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", 
  "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", 
  "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", 
  "C6", "C#6", "D6", "D#6", "E6", "F6", "F#6", "G6", "G#6", "A6", "A#6", "B6", 
  "C7"
};

void setup() {
  fullScreen(P3D);

  reading_all_txt();

  setup_Midi();
  setup_Snow();
  setup_Character();
  setup_Telop();
  setup_WanColle();

  square_param=(SQUARESIDE/dist(snowfall_p1.getX(), snowfall_p1.getY(), snowfall_p3.getX(), snowfall_p3.getY()));
}

void draw() {
  background(0);
  noStroke();

  if (debugMode) {
    fill(255);
    stroke(#ffff00);

    if (save_state)text("save complete.", 5, height-5);

    text(keyingCount, 0, 10);
    text(simult_keying_count, 0, 30);
    text(count_true_chord+"/180", 0, 50);

    for (int i=0; i<12; i++) 
      for (int j=0; j<8; j++) 
        if (isKeying[i][j]) 
          text(scaleName[i+j*12+21], i*50, (j+21)*10);
  }

  draw_Snow();
  draw_Character();
  draw_Telop();
  draw_WanColle();

  Translate(); //マウスによる頂点操作
  GatheringMIDI();//打鍵情報の収集
}

void movieEvent(Movie m) {
  m.read();
}
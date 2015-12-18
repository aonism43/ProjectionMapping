PImage[] telop=new PImage[TELOP_NUM];//使える時間帯のテロップ画像
PImage[] NG_telop=new PImage[NG_TELOP_NUM];//使えない時間帯のテロップ画像
PImage[] use_telop;//流すテロップ
PImage logo;

boolean[] isDisplay;

int move=0;

void setup_Telop() {
  for (int i=0; i<TELOP_NUM; i++) {
    telop[i]=loadImage("telop/"+i+".png");
  }
  for (int i=0; i<NG_TELOP_NUM; i++) {
    NG_telop[i]=loadImage("telop/NGtelop/"+i+".png");
  }

  logo=loadImage("telop/logo.png");

  SetTelop();
}

void draw_Telop() {  
  for (int i=0; i<use_telop.length; i++) {
    if (isDisplay[i]) {
      beginShape();
      texture(use_telop[i]);
      vertex(telop_p1.getX(), telop_p1.getY(), 0+move, 0);
      vertex(telop_p5.getX(), telop_p5.getY(), 600+move, 0);
      vertex(telop_p7.getX(), telop_p7.getY(), 630+move, 0);
      vertex(telop_p9.getX(), telop_p9.getY(), 900+move, 0);
      vertex(telop_p11.getX(), telop_p11.getY(), 1200+move, 0);
      vertex(telop_p13.getX(), telop_p13.getY(), 1450+move, 0);
      vertex(telop_p2.getX(), telop_p2.getY(), 1600+move, 0);
      vertex(telop_p3.getX(), telop_p3.getY(), 1600+move, telop[i].height);
      vertex(telop_p14.getX(), telop_p14.getY(), 1450+move, telop[i].height);
      vertex(telop_p12.getX(), telop_p12.getY(), 1200+move, telop[i].height);
      vertex(telop_p10.getX(), telop_p10.getY(), 900+move, telop[i].height);
      vertex(telop_p6.getX(), telop_p6.getY(), 630+move, telop[i].height);
      vertex(telop_p8.getX(), telop_p8.getY(), 600+move, telop[i].height);
      vertex(telop_p4.getX(), telop_p4.getY(), 0+move, telop[i].height);
      endShape(CLOSE);

      if (move>-TELOP_MOVE) {
        move=TELOP_MOVE;
        isDisplay[i]=false;

        if (i+1==use_telop.length) isDisplay[0]=true;
        else isDisplay[i+1]=true;
      }

      if (frameCount%telopSpeed==0) {
        if (debugMode) {
          if (keyPressed) move-=TELOP_SPEED;
          if (!(mousePressed))move+=TELOP_SPEED;
        }
        move+=TELOP_SPEED;
      }
    }
  }
}
void SetTelop() {
  if (isUsingPiano) use_telop=telop;
  else use_telop=NG_telop;

  isDisplay=new boolean[use_telop.length];
  isDisplay[0]=true;
}
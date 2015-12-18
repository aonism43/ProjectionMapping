PImage[] characterimg=new PImage[CHARACTER_NUM];//キャラの画像
PImage[] characterimg_beckon=new PImage[2];
boolean beckon=true;

int characterState=0;//キャラの成長度
int beckoningState=1;
int beckoning_interval=1;

void setup_Character() {
  for (int i=0; i<CHARACTER_NUM; i++)
    characterimg[i]=loadImage("character/"+i+".png");

  characterimg_beckon[0]=loadImage("character/t1.png");
  characterimg_beckon[1]=loadImage("character/t2.png");
}

void draw_Character() {
  characterState=min(keyingCount/GROATH_SPEED, CHARACTER_NUM-1);

  if (frameCount%(beckoning_interval*30)==0) beckoningState*=-1;

  if (beckon) {
    beginShape();
    if (beckoningState>0) texture(characterimg_beckon[0]);
    else texture(characterimg_beckon[1]);
    vertex(chara_p1.getX(), chara_p1.getY(), 0, 0);
    vertex(chara_p2.getX(), chara_p2.getY(), characterimg_beckon[0].width, 0);
    vertex(chara_p4.getX(), chara_p4.getY(), characterimg_beckon[0].width, characterimg_beckon[0].height);
    vertex(chara_p3.getX(), chara_p3.getY(), 0, characterimg_beckon[0].height);
    endShape(CLOSE);
  } else {
    beginShape();
    texture(characterimg[characterState]);
    vertex(chara_p1.getX(), chara_p1.getY(), 0, 0);
    vertex(chara_p2.getX(), chara_p2.getY(), characterimg[characterState].width, 0);
    vertex(chara_p4.getX(), chara_p4.getY(), characterimg[characterState].width, characterimg[characterState].height);
    vertex(chara_p3.getX(), chara_p3.getY(), 0, characterimg[characterState].height);
    endShape(CLOSE);
  }

  beginShape();
  texture(characterimg[characterState]);
  vertex(chara_p5.getX(), chara_p5.getY(), 0, 0);
  vertex(chara_p6.getX(), chara_p6.getY(), characterimg[characterState].width, 0);
  vertex(chara_p8.getX(), chara_p8.getY(), characterimg[characterState].width, characterimg[characterState].height);
  vertex(chara_p7.getX(), chara_p7.getY(), 0, characterimg[characterState].height);
  endShape(CLOSE);
}
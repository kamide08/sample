import processing.data.*;
import java.util.Arrays;

int me = 1; //デフォルトの自分(マリオ：1　　クリボー：2)
int auto = 0;   //二人モード  :  0      無人モード  :  1      一人モード(マリオを動かす)  :  2
int fieldtype = 7; //フィールドを選ぶ。     0：ランダム  1〜19：フィールドデータの番号(A11,A13,A15・・・B11,B13,B15・・・C11,C13,C15・・の順)
int suport = 0;//サポートツールを使うなら1使わないなら0
int vertical = 11;    //縦の長さ
int beside = 11;      //横の長さ

//↑試合ごとに変えるパラメータ



int craftsmannum = 6;   //職人の数
int castlenum = 73;           //城の数
int pondnum = 162;             //池の数
int craftsmanAX[] = new int [craftsmannum];       //職人Aのx座標が入っている
int craftsmanAY[] = new int [craftsmannum];
int craftsmanBX[] = new int [craftsmannum];
int craftsmanBY[] = new int [craftsmannum];
int castleX[] = new int  [castlenum];                       //城のx座標が入っている
int castleY[] = new int [castlenum];
int pondX[] = new int [pondnum];                             //池のx座標が入っている
int pondY[] = new int [pondnum];
PImage craftsA, craftsB, castlepi, craftsma, craftsku;
int turn = 1; //ターン数
int turnmotion = 10;           //誰のターンか表す　　　　　10の位が1ならマリオ、2ならクリボーのターン　　　　　　　　1の位は0 〜 4で、職人の番号を表す
int number;
int fill = 0;
int keycheck = 0;
int motion = -1;
int direction = -1;
int wall [][] = new int [25][25];
int tem_wall [][] = new int [25][25];
int motion20 = 0;
int motion21 = 0;
int motion22 = 0;
boolean distance [][] = new boolean [25][25];
int suport_di [][] = new int [25][25] ;
int open_bx [] = new int [200];
int open_by [] = new int [200];
int open_gx [] = new int [200];
int open_gy [] = new int [200];
int wallb_po [] = new int [100];
int wallb_po_num = 0;
int wallg_po [] = new int [100];
int wallg_po_num = 0;
int suport_size = 30;

int time  = 0;
int time2 = 3;
int start = 0;
boolean suport_check;

void setup() {
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  size(1300, 800);

  set();  //初期設定
  suport_tool();
  paint();//フィールドの線や職人などを描く
}

void draw() {
  noStroke();
  fill(255);
  square(30, 150, 100);
  textSize(40);
  fill(0);
  text(time2, 30, 200);
  if (start == 1) {
    time ++;
    if (time == 60) {
      time = 0;
      time2 --;
      if(time2 == -1){
        time2 = 2;
        faile();
      }
    }
  }
  paintdraw();   //どの職人のターンかを示す丸を描く
  if ((keycheck == 0 && auto == 0) || (auto == 2 && turnmotion < 20 && keycheck == 0)) {
    keyPress();
  }

  if (turn > 100)auto = 0;
}

void suport_tool() {
  /*
  概要
  領域に早く行けるのがどちらなのかを示すために早く行ける方の領域をsuport_diに追加する(男の子の方が早く行けるなら1、女の子の方が早く行けるなら2)
  */
  for (int i = 0  ; i < vertical - 1 ; i ++ ){ //suport_diの初期化
    for (int j = 0 ; j < vertical - 1 ; j++){
      suport_di[i][j] = 0;
    }
  }
  for (int i = 0; i < 200; i++) {
    open_bx[i] = -1;
    open_by[i] = -1;
    open_gx[i] = -1;
    open_gy[i] = -1;
  }
  for (int i = 0; i < 100; i ++) {
    wallg_po[i] = -1;
    wallb_po[i] = -1;
  }

  for (int i = 0; i < craftsmannum; i ++) {
    open_bx[i] = (craftsmanAX[i] - 200) / 30;
    open_by[i] = (craftsmanAY[i] - 10) / 30;
    open_gx[i] = (craftsmanBX[i] - 202) / 30;
    open_gy[i] = (craftsmanBY[i] - 12) / 30;
  }
  println(open_bx[0]);

  boolean boy = true, girl = true; //<>//

  if (turnmotion <= 20) {
    while (boy || girl) {
      if (girl) {
        if (search_g() == 0)girl = false;
      }
      if (boy) {
        if (search_b() == 0)boy = false;
      }
    }
  } else {
    while (boy || girl) {
      if (boy) {
        if (search_b() == 0)boy = false;
      }
      if (girl) {
        if (search_g() == 0)girl = false;
      }
    }
  }
}

int search_b() {
  /*
  概要
  男の子の次のターンで行ける領域をopenに追加する
  
  戻り値
  次のターンで行ける領域があれば1、なければ0
  */
  boolean end = false;
  int nextx [] = new int [200];
  int nextx_num = 0;
  int nexty [] = new int [200];
  int nexty_num = 0;
  int nextwall [] = new int [100];
  int nextwall_num = 0;
  for (int i = 0 ; i < 200 ; i ++){
    nextx[i] = -1;
    nexty[i] = -1;
  }
  for (int i = 0; i < 100 ; i++){
    nextwall[i] = -1;
  }


  for (int i = 0; open_bx[i] != -1 && open_by[i] != -1; i ++) {
    boolean  ok [] = new boolean [8];
    for (int j = 0; j < 8; j++) {
      ok[j] = true;
    }


    for (int j = 0; j < pondnum; j ++ ) {
      int x = pondX[j] - 200 / 30;
      int y = pondY[j] - 10 / 30;
      if (open_bx[i] - 1 <= x  && open_bx[i] + 1>= x && open_by[i] - 1 <= y  && open_by[i] + 1>= y) {  //移動できる範囲に池があるかを調べる
        if (open_bx[i] - 1 == x ) {
          if (open_by[i] - 1 == y ) {//左上に池がある
            ok[0] = false;
          } else if (open_by[i] == y) {//左に池がある
            ok[7] = false;
          } else if (open_by[i] + 1 == y) {//左下にが池ある
            ok[6] = false;
          }
        } else if (open_bx[i] == x) {
          if (open_by[i] - 1 == y ) {//上に池がある
            ok[1] = false;
          } else if (open_by[i] + 1 == y) {//下に池がある
            ok[5] = false;
          }
        } else if (open_bx[i] + 1 == x) {
          if (open_by[i] - 1 == y ) {//右上に池がある
            ok[2] = false;
          } else if (open_by[i] == y) {//右に池がある
            ok[3] = false;
          } else if (open_by[i] + 1 == y) {//右下に池がある
            ok[4] = false;
          }
        }
      }
    }


    for (int j = 0; j < craftsmannum; j ++ ) {
      int x = craftsmanAX[j] - 200 / 30;
      int y = craftsmanAY[j] - 10 / 30;
      if (open_bx[i] - 1 <= x  && open_bx[i] + 1>= x && open_by[i] - 1 <= y  && open_by[i] + 1>= y) {  //移動できる範囲に職人がいるかを調べる
        if (open_bx[i] - 1 == x ) {
          if (open_by[i] - 1 == y ) {//左上に職人がいる
            ok[0] = false;
          } else if (open_by[i] == y) {//左に職人がいる
            ok[7] = false;
          } else if (open_by[i] + 1 == y) {//左下に職人がいる
            ok[6] = false;
          }
        } else if (open_bx[i] == x) {
          if (open_by[i] - 1 == y ) {//上に職人がいる
            ok[1] = false;
          } else if (open_by[i] + 1 == y) {//下に職人がいる
            ok[5] = false;
          }
        } else if (open_bx[i] + 1 == x) {
          if (open_by[i] - 1 == y ) {//右上に職人がいる
            ok[2] = false;
          } else if (open_by[i] == y) {//右に職人がいる
            ok[3] = false;
          } else if (open_by[i] + 1 == y) {//右下に職人がいる
            ok[4] = false;
          }
        }
      }
    }


    if (wallb_po_num != 0) {    //前の関数実行時に壁があったらそこをopenに入れる
      for (; wallb_po_num >= 0; wallb_po_num --) {
        nextx[nextx_num] = wallb_po[wallb_po_num] / 100 % 100;
        nexty[nexty_num] = wallb_po[wallb_po_num]  % 100;
        end = true;
        nextx_num ++;
        nexty_num ++;
      }
      wallb_po_num ++;
    }


    if (open_by[i] >= 1 && open_bx[i] >= 1 && wall[open_bx[i] - 1][open_by [i]- 1] != 0) {
      ok[0] = false;  //右上に壁がある
      nextwall[nextwall_num] = (open_bx[i] - 1) * 100 + open_by[i] - 1;
      nextwall_num ++;
    }
    if (open_by[i] >= 1 && wall[open_bx[i]][open_by [i]- 1] != 0) {
      ok[1] = false;        //上に壁がある
      nextwall[nextwall_num] = open_bx[i] * 100 + open_by[i] - 1;
      nextwall_num ++;
    }
    if (open_bx[i] <= vertical - 2 && open_by[i] >= 1 && wall[open_bx[i] + 1][open_by [i]- 1] != 0) {
      ok[2] = false;//左上に壁がある
      nextwall[nextwall_num] = (open_bx[i] + 1) * 100 + open_by[i] - 1;
      nextwall_num ++;
    }
    if (open_bx[i] <= vertical - 2 && wall[open_bx[i] + 1][open_by [i]] != 0) {
      ok[3] = false;     //左に壁がある
      nextwall[nextwall_num] = (open_bx[i] + 1) * 100 + open_by[i];
      nextwall_num ++;
    }
    if (open_bx[i] <= vertical - 2 && open_by[i] <= vertical - 2 && wall[open_bx[i] + 1][open_by [i]+ 1] != 0) {
      ok[4] = false;//左下に壁がある
      nextwall[nextwall_num] = (open_bx[i] + 1) * 100 + open_by[i] + 1;
      nextwall_num ++;
    }
    if ( open_by[i] <= vertical - 2 && wall[open_bx[i]][open_by [i]+ 1] != 0) {
      ok[5] = false;       //下に壁がある
      nextwall[nextwall_num] = open_bx[i] * 100 + open_by[i] + 1;
      nextwall_num ++;
    }
    if ( open_by[i] <= vertical - 2 && open_bx[i] >= 1 && wall[open_bx[i] - 1][open_by [i]+ 1] != 0) {
      ok[6] = false;//左下に壁がある
      nextwall[nextwall_num] = (open_bx[i] - 1) * 100 + open_by[i] + 1;
      nextwall_num ++;
    }
    if (open_bx[i] >= 1 && wall[open_bx[i] - 1][open_by [i]] != 0) {
      ok[7] = false;//左に壁がある
      nextwall[nextwall_num] = (open_bx[i] - 1) * 100 + open_by[i];
      nextwall_num ++;
    }


    if (open_bx[i] >= 1 && open_by[i] >= 1 && ok[0] == true && suport_di[open_bx[i] - 1][open_by[i] - 1] == 0) {
      suport_di[open_bx[i] - 1][open_by[i] - 1] = 1;
      nextx[nextx_num] = open_bx[i] - 1;
      nexty[nexty_num] = open_by[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_by[i] >= 1 && ok[1] == true && suport_di[open_bx[i]][open_by[i] - 1] == 0) {
      suport_di[open_bx[i]][open_by[i] - 1] = 1;
      nextx[nextx_num] = open_bx[i];
      nexty[nexty_num] = open_by[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_bx[i] <= vertical - 2 && open_by[i] >= 1 && ok[2] == true && suport_di[open_bx[i] + 1][open_by[i] - 1] == 0) {
      suport_di[open_bx[i] + 1][open_by[i] - 1] = 1;
      nextx[nextx_num] = open_bx[i] + 1;
      nexty[nexty_num] = open_by[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_bx[i] <= vertical - 2 && ok[3] == true && suport_di[open_bx[i] + 1][open_by[i]] == 0) {
      suport_di[open_bx[i] + 1][open_by[i]] = 1;
      nextx[nextx_num] = open_bx[i] + 1;
      nexty[nexty_num] = open_by[i];
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_bx[i] <= vertical - 2 && open_by[i] <= vertical - 2 && ok[4] == true && suport_di[open_bx[i] + 1][open_by[i] + 1] == 0) {
      suport_di[open_bx[i] + 1][open_by[i] + 1] = 1;
      nextx[nextx_num] = open_bx[i] + 1;
      nexty[nexty_num] = open_by[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_by[i] <= vertical - 2 && ok[5] == true && suport_di[open_bx[i]][open_by[i] + 1] == 0) {
      suport_di[open_bx[i]][open_by[i] + 1] = 1;
      nextx[nextx_num] = open_bx[i];
      nexty[nexty_num] = open_by[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_by[i] <= vertical - 2 &&open_bx[i] >= 1 && ok[6] == true && suport_di[open_bx[i] - 1][open_by[i] + 1] == 0) {
      suport_di[open_bx[i] - 1][open_by[i] + 1] = 1;
      nextx[nextx_num] = open_bx[i] - 1;
      nexty[nexty_num] = open_by[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_bx[i] >= 1 && ok[7] == true && suport_di[open_bx[i] - 1][open_by[i]] == 0) {
      suport_di[open_bx[i] - 1][open_by[i]] = 1;
      nextx[nextx_num] = open_bx[i] - 1;
      nexty[nexty_num] = open_by[i];
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
  }

  open_bx = nextx;
  open_by = nexty;
  wallb_po = nextwall;
  wallb_po_num = nextwall_num;
  
  if (end == true) {
    return 1;
  } else {
    return 0;
  }
}



int search_g() {
  /*
  概要
  女の子の次のターンで行ける領域をopenに追加する
  
  戻り値
  次のターンで行ける領域があれば1、なければ0
  */
  boolean end = false;
  int nextx [] = new int [200];
  int nextx_num = 0;
  int nexty [] = new int [200];
  int nexty_num = 0;
  int nextwall [] = new int [100];
  int nextwall_num = 0;
  for (int i = 0 ; i < 200 ; i ++){
    nextx[i] = -1;
    nexty[i] = -1;
  }
  for (int i = 0; i < 100 ; i++){
    nextwall[i] = -1;
  }


  for (int i = 0; open_gx[i] != -1 && open_gy[i] != -1; i ++) {
    boolean  ok [] = new boolean [8];
    for (int j = 0; j < 8; j++) {
      ok[j] = true;
    }


    for (int j = 0; j < pondnum; j ++ ) {
      int x = pondX[j] - 200 / 30;
      int y = pondY[j] - 10 / 30;
      if (open_gx[i] - 1 <= x  && open_gx[i] + 1>= x && open_gy[i] - 1 <= y  && open_gy[i] + 1>= y) {  //移動できる範囲に池があるかを調べる
        if (open_gx[i] - 1 == x ) {
          if (open_gy[i] - 1 == y ) {//左上に池がある
            ok[0] = false;
          } else if (open_gy[i] == y) {//左に池がある
            ok[7] = false;
          } else if (open_gy[i] + 1 == y) {//左下にが池ある
            ok[6] = false;
          }
        } else if (open_gx[i] == x) {
          if (open_gy[i] - 1 == y ) {//上に池がある
            ok[1] = false;
          } else if (open_gy[i] + 1 == y) {//下に池がある
            ok[5] = false;
          }
        } else if (open_gx[i] + 1 == x) {
          if (open_gy[i] - 1 == y ) {//右上に池がある
            ok[2] = false;
          } else if (open_gy[i] == y) {//右に池がある
            ok[3] = false;
          } else if (open_gy[i] + 1 == y) {//右下に池がある
            ok[4] = false;
          }
        }
      }
    }


    for (int j = 0; j < craftsmannum; j ++ ) {
      int x = craftsmanAX[j] - 200 / 30;
      int y = craftsmanAY[j] - 10 / 30;
      if (open_gx[i] - 1 <= x  && open_gx[i] + 1>= x && open_gy[i] - 1 <= y  && open_gy[i] + 1>= y) {  //移動できる範囲に職人がいるかを調べる
        if (open_gx[i] - 1 == x ) {
          if (open_gy[i] - 1 == y ) {//左上に職人がいる
            ok[0] = false;
          } else if (open_gy[i] == y) {//左に職人がいる
            ok[7] = false;
          } else if (open_gy[i] + 1 == y) {//左下に職人がいる
            ok[6] = false;
          }
        } else if (open_gx[i] == x) {
          if (open_gy[i] - 1 == y ) {//上に職人がいる
            ok[1] = false;
          } else if (open_gy[i] + 1 == y) {//下に職人がいる
            ok[5] = false;
          }
        } else if (open_gx[i] + 1 == x) {
          if (open_gy[i] - 1 == y ) {//右上に職人がいる
            ok[2] = false;
          } else if (open_gy[i] == y) {//右に職人がいる
            ok[3] = false;
          } else if (open_gy[i] + 1 == y) {//右下に職人がいる
            ok[4] = false;
          }
        }
      }
    }


    if (wallg_po_num != 0) {    //前の関数実行時に壁があったらそこをopenに入れる
      for (; wallg_po_num >= 0; wallg_po_num --) {
        nextx[nextx_num] = wallg_po[wallg_po_num] / 100 % 100;
        nexty[nexty_num] = wallg_po[wallg_po_num]  % 100;
        end = true;
        nextx_num ++;
        nexty_num ++;
      }
      wallg_po_num ++;
    }


    if (open_gy[i] >= 1 && open_gx[i] >= 1 && wall[open_gx[i] - 1][open_gy [i]- 1] != 0) {
      ok[0] = false;  //右上に壁がある
      nextwall[nextwall_num] = (open_gx[i] - 1) * 100 + open_gy[i] - 1;
      nextwall_num ++;
    }
    if (open_gy[i] >= 1 && wall[open_gx[i]][open_gy [i]- 1] != 0) {
      ok[1] = false;        //上に壁がある
      nextwall[nextwall_num] = open_gx[i] * 100 + open_gy[i] - 1;
      nextwall_num ++;
    }
    if (open_gx[i] <= vertical - 2 && open_gy[i] >= 1 && wall[open_gx[i] + 1][open_gy [i]- 1] != 0) {
      ok[2] = false;//左上に壁がある
      nextwall[nextwall_num] = (open_gx[i] + 1) * 100 + open_gy[i] - 1;
      nextwall_num ++;
    }
    if (open_gx[i] <= vertical - 2 && wall[open_gx[i] + 1][open_gy [i]] != 0) {
      ok[3] = false;     //左に壁がある
      nextwall[nextwall_num] = (open_gx[i] + 1) * 100 + open_gy[i];
      nextwall_num ++;
    }
    if (open_gx[i] <= vertical - 2 && open_gy[i] <= vertical - 2 && wall[open_gx[i] + 1][open_gy [i]+ 1] != 0) {
      ok[4] = false;//左下に壁がある
      nextwall[nextwall_num] = (open_gx[i] + 1) * 100 + open_gy[i] + 1;
      nextwall_num ++;
    }
    if (open_gy[i] <= vertical - 2 && wall[open_gx[i]][open_gy [i]+ 1] != 0) {
      ok[5] = false;       //下に壁がある
      nextwall[nextwall_num] = open_gx[i] * 100 + open_gy[i] + 1;
      nextwall_num ++;
    }
    if (open_gy[i] <= vertical - 2 && open_gx[i] >= 1 && wall[open_gx[i] - 1][open_gy [i]+ 1] != 0) {
      ok[6] = false;//左下に壁がある
      nextwall[nextwall_num] = (open_gx[i] - 1) * 100 + open_gy[i] + 1;
      nextwall_num ++;
    }
    if (open_gx[i] >= 1 && wall[open_gx[i] - 1][open_gy [i]] != 0) {
      ok[7] = false;//左に壁がある
      nextwall[nextwall_num] = (open_gx[i] - 1) * 100 + open_gy[i];
      nextwall_num ++;
    }


    if (open_gx[i] >= 1 && open_gy[i] >= 1 && ok[0] == true && suport_di[open_gx[i] - 1][open_gy[i] - 1] == 0) {
      suport_di[open_gx[i] - 1][open_gy[i] - 1] = 2;
      nextx[nextx_num] = open_gx[i] - 1;
      nexty[nexty_num] = open_gy[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gy[i] >= 1 && ok[1] == true && suport_di[open_gx[i]][open_gy[i] - 1] == 0) {
      suport_di[open_gx[i]][open_gy[i] - 1] = 2;
      nextx[nextx_num] = open_gx[i];
      nexty[nexty_num] = open_gy[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gx[i] <= vertical - 2 && open_gy[i] >= 1 && ok[2] == true && suport_di[open_gx[i] + 1][open_gy[i] - 1] == 0) {
      suport_di[open_gx[i] + 1][open_gy[i] - 1] = 2;
      nextx[nextx_num] = open_gx[i] + 1;
      nexty[nexty_num] = open_gy[i] - 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gx[i] <= vertical - 2 && ok[3] == true && suport_di[open_gx[i] + 1][open_gy[i]] == 0) {
      suport_di[open_gx[i] + 1][open_gy[i]] = 2;
      nextx[nextx_num] = open_gx[i] + 1;
      nexty[nexty_num] = open_gy[i];
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gx[i] <= vertical - 2 && open_gy[i] <= vertical - 2 && ok[4] == true && suport_di[open_gx[i] + 1][open_gy[i] + 1] == 0) {
      suport_di[open_gx[i] + 1][open_gy[i] + 1] = 2;
      nextx[nextx_num] = open_gx[i] + 1;
      nexty[nexty_num] = open_gy[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gy[i] <= vertical - 2 && ok[5] == true && suport_di[open_gx[i]][open_gy[i] + 1] == 0) {
      suport_di[open_gx[i]][open_gy[i] + 1] = 2;
      nextx[nextx_num] = open_gx[i];
      nexty[nexty_num] = open_gy[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gy[i] <= vertical - 2 &&open_gx[i] >= 1 && ok[6] == true && suport_di[open_gx[i] - 1][open_gy[i] + 1] == 0) {
      suport_di[open_gx[i] - 1][open_gy[i] + 1] = 2;
      nextx[nextx_num] = open_gx[i] - 1;
      nexty[nexty_num] = open_gy[i] + 1;
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
    if (open_gx[i] >= 1 && ok[7] == true && suport_di[open_gx[i] - 1][open_gy[i]] == 0) {
      suport_di[open_gx[i] - 1][open_gy[i]] = 2;
      nextx[nextx_num] = open_gx[i] - 1;
      nexty[nexty_num] = open_gy[i];
      nextx_num ++;
      nexty_num ++;
      end = true;
    }
  }

  open_gx = nextx;
  open_gy = nexty;
  wallg_po = nextwall;
  wallg_po_num = nextwall_num;

  if (end == true) {
    return 1;
  } else {
    return 0;
  }
}

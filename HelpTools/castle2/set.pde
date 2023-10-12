void set () {
  /*
  概要
  初期設定
  */
  if (fieldtype == 1 || fieldtype == 7 || fieldtype == 13) {
    beside = 11;
    vertical = 11;
  } else if (fieldtype == 2 || fieldtype == 8 || fieldtype == 14) {
    beside = 13;
    vertical = 13;
  } else if (fieldtype == 3 || fieldtype == 9 || fieldtype == 15) {
    beside = 15;
    vertical = 15;
  } else if (fieldtype == 4 || fieldtype == 10 || fieldtype == 16) {
    beside = 17;
    vertical = 17;
  } else if (fieldtype == 5 || fieldtype == 11 || fieldtype == 17) {
    beside = 21;
    vertical = 21;
  } else if (fieldtype == 6 || fieldtype == 12 || fieldtype == 18) {
    beside = 25;
    vertical = 25;
  } 

  if (fieldtype == 0) { //ランダムに決める。この時に入るのは、座標ではなくマス目の番号
    for (int i = 0, tem = int(random(0, beside)), check = 0; i < castlenum; check = 0) {
      for (int j = 0; j < castlenum; j ++ ) {
        if (castleX[j] == tem)check = 1;
      }
      if (check == 0) {
        castleX[i] = tem;
        i ++;
      }
      tem = int(random(0, beside));
    }

    for (int i = 0, tem = int(random(0, beside)), check = 0; i < castlenum; check = 0) {
      for (int j = 0; j < castlenum; j ++ ) {
        if (castleY[j] == tem)check = 1;
      }
      if (check == 0) {
        castleY[i] = tem;
        i ++;
      }
      tem = int(random(0, beside));
    }

    for (int i = 0, tem1 = int(random(0, beside)), tem2 = int(random(0, beside)), check = 0; i < pondnum; check = 0) {
      for (int j = 0; j < castlenum; j ++) {
        if (castleX[j] == tem1 && castleY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j < pondnum; j ++) {
        if (pondX[j] == tem1 && pondY[j] == tem2) {
          check = 1;
          break;
        }
      }
      if (check == 0) {
        pondX[i] = tem1;
        pondY[i] = tem2; 
        i ++;
      }
      tem1 = int(random(0, beside));
      tem2 = int(random(0, beside));
    }

    for (int i = 0, tem1 = int(random(0, beside)), tem2 = int(random(0, beside)), check = 0; i < craftsmannum; check = 0) {
      for (int j = 0; j <castlenum; j ++) {
        if (castleX[j] == tem1 && castleY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j < pondnum; j ++) {
        if (pondX[j] == tem1 && pondY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j < craftsmannum; j ++) {
        if (craftsmanAX[j] == tem1 && craftsmanAY[j] == tem2) {
          check = 1;
          break;
        }
      }
      if (check == 0) {
        craftsmanAX[i] = tem1;
        craftsmanAY[i] = tem2;
        i ++;
      }
      tem1 = int(random(0, beside));
      tem2 = int(random(0, beside));
    }

    for (int i = 0, tem1 = int(random(0, beside)), tem2 = int(random(0, beside)), check = 0; i < craftsmannum; check = 0) {
      for (int j = 0; j <castlenum; j ++) {
        if (castleX[j] == tem1 && castleY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j <pondnum; j ++) {
        if (pondX[j] == tem1 && pondY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j <craftsmannum; j ++ ) {
        if (craftsmanAX[j] == tem1 && craftsmanAY[j] == tem2) {
          check = 1;
          break;
        }
      }
      for (int j = 0; j < craftsmannum; j ++) {
        if (craftsmanBX[j] == tem1 && craftsmanBY[j] == tem2) {
          check = 1;
          break;
        }
      }
      if (check == 0) {
        craftsmanBX[i] = tem1;
        craftsmanBY[i] = tem2;
        i ++;
      }
      tem1 = int(random(0, beside));
      tem2 = int(random(0, beside));
    }
  } else {
    setfield(fieldtype);
  }


  //ここからマス目の番号を座標に変える

  for (int i = 0; i < castlenum; i ++ ) {
    castleX[i] = 203 + castleX[i] * 30;
    castleY[i] = 13 + castleY[i] * 30;
  }

  for (int i = 0; i < pondnum; i ++ ) {
    pondX[i] = 200 + pondX[i] * 30;
    pondY[i] = 10 + pondY[i] * 30;
  }

  for (int i = 0; i < craftsmannum; i ++ ) {
    craftsmanAX[i] = 200 + craftsmanAX[i] * 30;
    craftsmanAY[i] = 10 + craftsmanAY[i] * 30;
    craftsmanBX[i] = 202 + craftsmanBX[i] * 30;
    craftsmanBY[i] = 12 + craftsmanBY[i] * 30;
  }

  craftsA = loadImage("1.png");
  craftsB = loadImage("kuri.png");
  craftsma = loadImage("1.png");
  craftsku = loadImage("kuri.png");
  castlepi = loadImage("castle.png");

  craftsA.resize(30, 30);
  craftsB.resize(30, 30);
  craftsma.resize(80, 80);
  craftsku.resize(80, 80);
  castlepi.resize(25, 25);

  for (int i = 0; i < vertical; i ++ ) {
    for (int j = 0; j < beside; j ++ ) {
      wall[i][j] = 0;
      tem_wall[i][j] = 0;
    }
  }
}

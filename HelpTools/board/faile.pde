void faile() {
  /*
  概要
  jsonファイルから壁と職人の位置を読み込み、反映さえる
  */
  // JSONデータを文字列として読み込む
  String[] jsonDataLines = loadStrings("/Users/kamiderikuya/Documents/プロコン/data.text");

  // 文字列の配列を結合して1つの文字列にする
  String jsonData = join(jsonDataLines, "\n");

  // JSONデータを解析
  JSONObject data = parseJSONObject(jsonData);

  if (data != null) {
    int turn_tem = data.getInt("turn");
    turn = turn_tem;
        
    // "board" オブジェクトから "structures" と "masons" 配列を取得
    JSONArray structures = data.getJSONObject("board").getJSONArray("walls");
    JSONArray masons = data.getJSONObject("board").getJSONArray("masons");

    // structures を2次元のint型配列に変換
    int[][] structuresArray = new int[structures.size()][structures.getJSONArray(0).size()];
    for (int i = 0; i < structures.size(); i++) {
      JSONArray row = structures.getJSONArray(i);
      for (int j = 0; j < row.size(); j++) {
        structuresArray[i][j] = row.getInt(j);
      }
    }

    // masons を2次元のint型配列に変換
    int[][] masonsArray = new int[masons.size()][masons.getJSONArray(0).size()];
    for (int i = 0; i < masons.size(); i++) {
      JSONArray row = masons.getJSONArray(i);
      for (int j = 0; j < row.size(); j++) {
        masonsArray[i][j] = row.getInt(j);
      }
    }

    // 配列の内容を表示（デバッグ用）
    for (int i = 0; i < structuresArray.length; i++) {
      for (int j = 0; j < structuresArray[i].length; j++) {
        if(structuresArray[i][j] == 1){
          wall[i][j] = me;
        } else if (structuresArray[i][j] == 2){
          if (me == 1){
            wall[j][i] = 2;
          } else {
            wall[j][i] = 1;
          }
        }
      }
    }
    int me_ = 0;
    int enemy = 0;
    for (int i = 0; i < masonsArray.length; i++) {
      for (int j = 0; j < masonsArray[i].length; j++) {
        if (masonsArray[j][i] != 0){
          if (masonsArray[j][i] > 0){
            if (me == 1){
              craftsmanAX[masonsArray[j][i] - 1] = 200 + i * 30;
              craftsmanAY[masonsArray[j][i] - 1] = 10 + j * 30;
            } else {
              craftsmanBX[masonsArray[j][i] - 1] = 202 + i * 30;
              craftsmanBY[masonsArray[j][i] - 1] = 12 + j * 30;
            }
            me_++;
          } else {
            if (me == 1){
              craftsmanBX[enemy] = 202 +i * 30;
              craftsmanBY[enemy] = 12 + j * 30;
            } else {
              craftsmanAX[enemy] = 200 + i * 30;
              craftsmanAY[enemy] = 10 + j * 30;
            }
            enemy ++;
          }
        }
      }
    }
    paint();
  } else {
    println("JSONデータの解析に失敗しました");
  }
}

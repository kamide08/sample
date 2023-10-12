let Http_1 = new XMLHttpRequest();
let Http_2 = new XMLHttpRequest();
let Http_3 = new XMLHttpRequest();
const url_1 = 'https://www.procon.gr.jp/matches?token=ishikawaf2fef51f933e2ab4095ca4f690269c76aa01d0fe1a6a0e312f918810';
const url_2 = 'https://www.procon.gr.jp/matches/10?token=ishikawaf2fef51f933e2ab4095ca4f690269c76aa01d0fe1a6a0e312f918810';
let btn = document.getElementById('button');
let game_number;//参加する試合の番号
let games;//参加する試合
let maxLength = 2;//この文字数を超えたら次のフォームに移る
let get;//getで受け取ったデータを入れる
let inputNumber;//職人の数を記録
let myVariable;
let post = {
    "turn": 0,
    "actions": []
};
let mason_actions = [

    {
        "type": 0,
        "dir": 0
    },
    {
        "type": 0,
        "dir": 0
    },
    {
        "type": 0,
        "dir": 0
    },
    {
        "type": 0,
        "dir": 0
    },
    {
        "type": 0,
        "dir": 0
    },
    {
        "type": 0,
        "dir": 0
    }
];


function GET_First() {
    Http_1.open('GET', url_1);
    Http_1.send();
}

function POST() {
    setValue();
    SetPost();
    Http_2.open('POST', url_2, false);
    Http_2.setRequestHeader('content-type', 'application/json');
    console.log(JSON.stringify(post));
    Http_2.send(JSON.stringify(post));
}

function GET_Always() {
    Http_3.open('GET', url_2);
    Http_3.send();
}

function moveToNextField(currentField, nextFieldId) {
    let currentLength = currentField.value.length;

    if (currentLength >= maxLength) {
        document.getElementById(nextFieldId).focus();//次のフォームに移る
    }
}

function setValue() {//職人の行動番号をjson形式に直す
    let i;
    let action;
    let type;
    let dir;
    let masonNumber = inputNumber;
    for (i = 0; i < masonNumber; i++) {
        action = document.getElementById(i)
        type = Math.floor(action.value / 10);
        dir = action.value % 10;
        mason_actions[i].type = type;
        mason_actions[i].dir = dir;
    }
    let form = document.getElementById("mason")
    form.reset();//行動入力フォームをリセットします
    console.log(post);
    document.getElementById("0").focus();
}

Http_1.onreadystatechange = (e) => {
    if (Http_1.readyState == 4) {
        if (Http_1.status == 200) {
            get = JSON.parse(Http_1.responseText);
            alert("読み込みに成功しました。");
            CheckFirst(get);
            CheckTime(get);
            CheckTotalTurn(get);
        }
        else {
            alert("読み込みに失敗しました。")
        }
    }
}

Http_2.onreadystatechange = (e) => {//行動計画を送信
    if (Http_2.readyState == 4) {
        if (Http_2.status == 200) {
            let res = Http_2.responseText;
            console.log(res);
            alert("送信に成功しました。");
            post.actions = [];
        }
        else {
            alert("送信に失敗しました。")
            post.actions = [];
        }
    }
    else {
        // エラーステータスが返された場合の処理
        console.log('リクエストがエラーを返しました。ステータスコード: ' + Http_2.status);
    }
}

Http_3.onreadystatechange = (e) => {//盤面状況を取得
    if (Http_3.readyState == 4) {
        if (Http_3.status == 200) {
            get = JSON.parse(Http_3.responseText);
            console.log(get);
            alert("読み込みに成功しました。");
            Checkmason_Number(get);
            CheckCurrentTurn(get);
        }
        else {
            alert("読み込みに失敗しました。")
        }
    }
}

function CheckFirst(get) {//先手か後手か確認する
    if (get.matches[0].first) {
        const turn = document.getElementById('turn');
        turn.textContent = "手番は先手です。"
    }
    else {
        const turn = document.getElementById('turn');
        turn.textContent = "手番は後手です。"
    }
}

function CheckTime(get) {//1ターンあたりの時間を確認
    let time = get.matches[0].turnSeconds;
    let LimitTime = document.getElementById('game_time');
    console.log(LimitTime);
    LimitTime.textContent = `制限時間は${time}です。`
}

function CheckTotalTurn(get) {//合計ターン数を確認
    let total_turn = get.matches[0].turns;
    let TotalTurn = document.getElementById('TotalTurn');
    TotalTurn.textContent = `ターン数は${total_turn}です。`
}


function Checkmason_Number_main() {//職人の数を確認しinputNumberに代入
    let hasRun = false;

    return function (get) {
        if (!hasRun) {
            const number = document.getElementById('mason_number');
            number.textContent = `職人の数は${get.board.mason}人です。`
            hasRun = true;
            inputNumber = get.board.mason;
        }
    }
}
const Checkmason_Number = Checkmason_Number_main();

function CheckCurrentTurn(get) {//現在のターンを確認する
    console.log(get.turn);
    let current_turn = parseInt(get.turn) + 1;
    post.turn = current_turn;
    let CurrentTurn = document.getElementById('CurrentTurn');
    CurrentTurn.textContent = `現在のターンは${current_turn}です。`
    console.log(post.turn);
}

function SetPost() {
    let i;
    for (i = 0; i < inputNumber; i++) {
        post.actions.push(mason_actions[i]);
    }
    console.log(post);
}
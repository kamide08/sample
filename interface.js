const Http_1 = new XMLHttpRequest();
const Http_2 = new XMLHttpRequest();
const url_1 = 'http://localhost:3000/matches/?token=ishikawaf2fef51f933e2ab4095ca4f690269c76aa01d0fe1a6a0e312f918810';
const url_2 = 'http://localhost:3000/matches/10?token=ishikawaf2fef51f933e2ab4095ca4f690269c76aa01d0fe1a6a0e312f918810';
let btn = document.getElementById('button');
let maxLength = 2;//この文字数を超えたら次のフォームに移る
let get;//getで受け取ったデータを入れる
let inputValue;//入力フォームから受け取った値を入れる
let inputNumber;//職人の数を記録
let myVariable;
let post = {
    "turn": 0,
    "actions": []
};
let masson_actions = [
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
Http_1.open('GET', url_1);
Http_2.open('POST', url_2);
function GET() {
    Http_1.send();
}
function POST() {
    setValue();
    Http_2.send();
}

function moveToNextField(currentField, nextFieldId) {
    let currentLength = currentField.value.length;

    if (currentLength >= maxLength) {
        document.getElementById(nextFieldId).focus();//次のフォームに移る
    }
}

function getMasson_number() {//職人の数を取得
    inputNumber = document.getElementById("massons_number").value;
    console.log("職人の数は" + inputNumber + "人です。");
}

function setValue() {//職人の行動番号をjson形式に直す
    let i;
    let action;
    let type;
    let dir;
    let massonNumber = inputNumber;
    for (i = 0; i < massonNumber; i++) {
        action = document.getElementById(i)
        type = Math.floor(action.value / 10);
        dir = action.value % 10;
        masson_actions[i].type = type;
        masson_actions[i].dir = dir;
        post.actions.push(masson_actions[i]);
    }
    let form = document.getElementById("masson")
    form.reset();//行動入力フォームをリセットします
    console.log(post);
    document.getElementById("0").focus();
}

Http_1.onreadystatechange = (e) => {
    if (Http_1.readyState == 4) {
        get = Http_1.responseText;
        console.log(get);
        alert("読み込みに成功しました。");
    }
}

Http_2.onreadystatechange = (e) => {
    if (Http_2.readyState == 4) {
        post = Http_2.responseText;
        console.log(post);
        alert("送信に成功しました。");
        post.actions = [];
    }
}

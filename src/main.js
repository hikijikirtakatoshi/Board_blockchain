import "babel-polyfill";
import Web3 from "web3";
import Board from '../build/contracts/Board.json';

const smartContractAddress = "0x0AA6e322f52C0aE5999BcC5b210c93e4C8d63D2E";
let myAccount;
let web3;
let contractInstance;

async function initApp() {
    myAccount = (await web3.eth.getAccounts())[0];
    contractInstance = new web3.eth.Contract(Board.abi, smartContractAddress);
}

// 新規投稿のための関数
window.contribute = async () => {

    let sentence = document.getElementById("text_area").value;
    if (!sentence) { alert("文字列を入力してください"); }
    try {
        let option = {
            from: myAccount,
            gasPrice: "20000000000",
            gas: "4100000",
        };
        await contractInstance.methods.contribute(sentence).send(option);
    } catch (err) {
        console.log(err);
    }
};

// 掲示板の内容を取得するための関数

window.refresh = async () => {
    try {
        await contractInstance.methods.getContributes().call();
        // contributes.reverse().forEach(function (contribute) {
        //     // var div = document.createElement('div');
        //     // div.classList.add('contribution');
        //     // div.innerText = "> " + contribute[0];
        //     // document.getElementById("contributions").appendChild(div);
        //     console.log("きてる");
        // });
    } catch (err) {
        console.log(err);
    }
};

// 投げ銭する関数

window.addEventListener('load', async function () {
    if (typeof window.ethereum !== 'undefined' || (typeof window.web3 !== 'undefined')) {
        let provider = window['ethereum'] || window.web3.currentProvider;
        await provider.enable();
        web3 = new Web3(provider);
    } else {
        console.log('METAMASK NOT DETECTED');
    }
    initApp();
});
require('dotenv').config();
const BigNumber = require('bignumber.js');
global.Web3 = require('web3');
global.web3 = new Web3(new Web3.providers.HttpProvider(process.env.INFURA_ENDPOINT));
global.log = (message) => console.log(message);
global.error = (message) => console.log(message);
global.ether = (value) => new BigNumber(value * Math.pow(10, 18));

const Tori = require('./scripts/Tori.js');

if (process.env.PRIVATE_KEY) {
    web3.eth.accounts.wallet.add(process.env.PRIVATE_KEY);
    log(`CURRENT_ADDRESS : ${web3.eth.accounts.wallet[0].address}`);
} else {
    error(`Please register your private key! (.env.${process.env.NODE_ENV} file)`)
    process.exit(0)
}

global.sendDefaultParams = {
    from: web3.eth.accounts.wallet[0].address,
    gas: 4500000,
    gasPrice: '1000000000'
}

// validation token amount
let totalSupply = Number(process.env.TOTAL_SUPPLY);
if (!totalSupply || totalSupply == 0) {
    error('TOTAL_SUPPLY = 0')
    return;
}

try {
    console.log(']---]ToriToken contract[---[');
    console.log(process.env.INFURA_ENDPOINT);

    Tori(process.env.TOTAL_SUPPLY).then(function(res) {
        console.log(res);
        process.exit(0);
    }).catch((error) => {
        console.log(error);
    });

} catch(error) {
    console.log(error);
}
// console.log(`TORI Token : ${tori.options.address}`);
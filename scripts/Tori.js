const fs = require('fs');
const contractJson = JSON.parse(fs.readFileSync('build/contracts/Tori.json'));
const contract = new web3.eth.Contract(contractJson.abi);
const BigNumber = require('bignumber.js');
const decimals = Math.pow(10, 18);

module.exports = async (initialSupply) => {

    console.log(`token deploying...`);

    let instance = await contract.deploy({
        data: contractJson.bytecode,
        arguments: [new BigNumber(initialSupply * decimals).toFixed()]
    })
    .send(sendDefaultParams)
    .then((res) => {
            console.log(`token deployed!...`);
            return res;        
    }).catch(function(error) {
        console.log(error);
    });

    console.log(instance);
    return instance;
};
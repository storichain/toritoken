const fs = require('fs');
const contractJson = JSON.parse(fs.readFileSync('build/contracts/Tori.json'));
const contract = new web3.eth.Contract(contractJson.abi);
const replace = require('replace-in-file');
const BigNumber = require('bignumber.js');
const decimals = Math.pow(10, 18);

module.exports = async (initialSupply) => {

    let instance = await contract.deploy({
        data: contractJson.bytecode,
        arguments: [new BigNumber(initialSupply * decimals)]
    }).send(sendDefaultParams);

    replace({
        files: `.env.${process.env.NODE_ENV}`,
        from: /TORI_ADDRESS=.*/g,
        to: `TORI_ADDRESS=${instance.options.address}`
    });

    console.log(instance.options.address);

    return instance;
};
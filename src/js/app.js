// console.log("app.js loaded");
App = {
    web3Provider: null,
    contracts: {},

    init: function() {
        console.log("App Initlized...");
        return App.initWeb3();
    },
    
    initWeb3: function(){
        if (typeof web3 !== 'undeifned'){
            // If a web3 instance already provided by meta mask
            App.web3Provider = web3.currentProvider;
            web3 = new Web3(web3.currentProvider);
        }else {
            App.web3Provider = new Web3.provider.HttpProvider('http://localhost:7545');
            web3 = new Web3(App.web3Provider);
        }
        return App.initContracts();
    },

    initContracts: function(){
        $.getJSON("DappTokenSale.json", function(dappTokenSale) {
        App.contracts.DappTokenSale = TruffleContract(dappTokenSale);
        App.contracts.DappTokenSale.setProvider(App.web3Provider);
        App.contracts.DappTokenSale.deployed().then(function(dappTokenSale){
            console.log("DappTokenSale Address:", dappTokenSale.address);
        });
        })
    },
}

$(function(){
    $(window).ready(function(){
        App.init();
    })
});
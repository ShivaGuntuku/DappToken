// console.log("app.js loaded");
App = {
    init: function() {
        console.log("App Initlized...");
    }
}

$(function(){
    $(window).load(function(){
        App.init();
    })
});
/*
 *  _   _       _                       _ 
 * | \ | | ___ | |_ ___ _ __   __ _  __| |
 * |  \| |/ _ \| __/ _ \ '_ \ / _` |/ _` |
 * | |\  | (_) | ||  __/ |_) | (_| | (_| |
 * |_| \_|\___/ \__\___| .__/ \__,_|\__,_|
 *                     |_|                
 * By: Jason Stallings
 */

var gui = require("nw.gui");

//Get the current window.
var win = gui.Window.get();

//Show the window when the app opens.
win.show();

//Dom ready!
$(document).on("ready", function()
{
    //Focus the window.
    win.focus();
    
    //Focus our textarea.
    $("#mainText").focus();
    
    //Close button.
    $("#titlebarClose").on("click", function()
    {
        win.close();
    });
    
    //Maximize button.
    $("#titlebarMaximize").on("click", function()
    {
        win.maximize();
    });
    
    //Minimize button.
    $("#titlebarMinimize").on("click", function()
    {
        win.minimize();
    });
});

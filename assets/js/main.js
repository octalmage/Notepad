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

//Get screen size.
var screen = gui.Screen.Init();

if (process.platform === "darwin")
{
	var nativeMenuBar = new gui.Menu(
	{
		type: "menubar"
	});
	nativeMenuBar.createMacBuiltin("Notepad");
	win.menu = nativeMenuBar;
}

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
        //Unmaximize if window is already maximized.
        if (win.height === screen.availHeight && win.width === screen.availWidth)
        {
            win.unmaximize();
            
            //Switch to maximize button.
            $("#titlebarMaximize img").attr("src", "assets/img/titlebar/maximize.png");
        }
        else 
        {
            win.maximize();
            
            //Switch to unmaximize button.
            $("#titlebarMaximize img").attr("src", "assets/img/titlebar/unmaximize.png");
        }
    });
    
    //Minimize button.
    $("#titlebarMinimize").on("click", function()
    {
        win.minimize();
    });
});

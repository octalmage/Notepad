/*
 *  _   _       _                       _
 * | \ | | ___ | |_ ___ _ __   __ _  __| |
 * |  \| |/ _ \| __/ _ \ '_ \ / _` |/ _` |
 * | |\  | (_) | ||  __/ |_) | (_| | (_| |
 * |_| \_|\___/ \__\___| .__/ \__,_|\__,_|
 *                     |_|
 * By: Jason Stallings
 */
const { remote } = require('electron');
const win = remote.getCurrentWindow();

const Elm = require('./elm.js');

// get a reference to the div where we will show our UI
let container = document.getElementById('container');

// start the elm app in the container
// and keep a reference for communicating with the app
let app = Elm.Main.embed(container);


app.ports.windowEvents.subscribe(function(button) {
  switch(button) {
    case "close":
      win.close();
      break;
    case "minimize":
      win.minimize();
      break;
    case "maximize":
      toggleMaximize();
      app.ports.maximizeStatus.send(win.isMaximized());
      break;
  }
});

//Dom ready!
// $(document).on('ready', function()
// {
//     //Focus our textarea.
//     $('#mainText').focus();
//
//     //Close button.
//     $('#titlebarClose').on('click', function()
//     {
//         win.close();
//     });
//
//     //Maximize button.
//     $('#titlebarMaximize').on('click', function()
//     {
//         toggleMaximize();
//     });
//
//     //Minimize button.
//     $('#titlebarMinimize').on('click', function()
//     {
//         win.minimize();
//     });
//
// 	$('#titlebar').on('dblclick', function()
// 	{
// 		toggleMaximize();
// 	});
//
// 	$('#fileMenu').on('click', function() {
// 		document.getElementById('myDropdown').classList.toggle('show');
// 	});
// });
//
function toggleMaximize()
{
	// Unmaximize if window is already maximized.
	if (win.isMaximized())
	{
		win.unmaximize();

		// Switch to maximize button.
		// $('#titlebarMaximize img').attr('src', 'assets/img/titlebar/maximize.png');
	}
	else
	{
		win.maximize();

		// Switch to unmaximize button.
		// $('#titlebarMaximize img').attr('src', 'assets/img/titlebar/unmaximize.png');
	}
}
//
// window.onclick = function(event) {
//   if (!event.target.matches('.menubarItem')) {
//
//     var dropdowns = document.getElementsByClassName('dropdown-content');
//     var i;
//     for (i = 0; i < dropdowns.length; i++) {
//       var openDropdown = dropdowns[i];
//       if (openDropdown.classList.contains('show')) {
//         openDropdown.classList.remove('show');
//       }
//     }
//   }
// }

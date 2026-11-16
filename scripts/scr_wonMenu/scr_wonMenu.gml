function WonMenu() : Menu() constructor
{
	inputDelay = 60; 

	tick = function()
	{
		if (inputDelay > 0) 
			inputDelay--; 
		else if (input.attack.pressed() || input.menu.pressed())
			game.setMenu(new TitleMenu()); 
	}

	render = function(screen)
	{
		global.Font.renderFrame(screen, "", 1, 3, 18, 9); 
		global.Font.draw("You won! Yay!", screen, 2 * 8, 4 * 8, global.Color.get(-1, 555, 555, 555)); 

		var seconds = game.gameTime div 60; 
		var minutes = seconds div 60; 
		var hours = minutes div 60; 
		minutes %= 60; 
		seconds %= 60;

		var timeString = ""; 
		if (hours > 0)
			timeString = string(hours) + "h" + (minutes < 10 ? "0" : "") + string(minutes) + "m";
		else
			timeString = string(minutes) + "m " + (seconds < 10 ? "0" : "") + string(seconds) + "s";
		
		global.Font.draw("Time:", screen, 2 * 8, 5 * 8, global.Color.get(-1, 555, 555, 555));
		global.Font.draw(timeString, screen, (2 + 5) * 8, 5 * 8, global.Color.get(-1, 550, 550, 550));
		global.Font.draw("Score:", screen, 2 * 8, 6 * 8, global.Color.get(-1, 555, 555, 555));
		global.Font.draw(string(game.player.scoreValue), screen, (2 + 6) * 8, 6 * 8, global.Color.get(-1, 550, 550, 550));
		global.Font.draw("Press C to win", screen, 2 * 8, 8 * 8, global.Color.get(-1, 333, 333, 333));
	}
}

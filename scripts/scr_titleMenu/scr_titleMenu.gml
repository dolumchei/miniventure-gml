function TitleMenu() : Menu() constructor
{
	selected = 0; 
	
	options = [ "Start game", "How to play", "About" ]; 

	static tick = function()
	{
		if (input.up.check())
			selected--; 
		if (input.down.check())
			selected++; 

		var len = array_length(options); 
		if (selected < 0)
			selected += len; 
		if (selected >= len)
			selected -= len; 

		if (input.attack.pressed() || input.menu.pressed())
		{ 
			if (selected == 0)
			{ 
				global.Sound.test.play(); 
				game.resetGame(); 
				game.setMenu(undefined); 
			}
			if (selected == 1)
				game.setMenu(new InstructionsMenu(self)); 
			if (selected == 2)
				game.setMenu(new AboutMenu(self)); 
		}
	}

	static render = function(screen)
	{
		screen.clear(#0A0A0A);
		var h = 2; 
		var w = 13; 
		var titleColor = global.Color.get(0, 010, 131, 551); 
		var xo = (screen.w - w * 8) / 2; 
		var yo = 24; 
		for (var yy = 0; yy < h; yy++)
		{
			for (var xx = 0; xx < w; xx++)
				screen.render(xo + xx * 8, yo + yy * 8, xx + (yy + 6) * 32, titleColor, 0); 
		}
		for (var i = 0; i < array_length(options); i++)
		{ 
			var msg = options[i]; 
			var col = global.Color.get(0, 222, 222, 222); 
			if (i == selected)
			{ 
				msg = "> " + msg + " <"; 
				col = global.Color.get(0, 555, 555, 555); 
			}
			global.Font.draw(msg, screen, (screen.w - string_length(msg) * 8) / 2, (8 + i) * 8, col); 
		}

		global.Font.draw("(Arrow keys,X and C)", screen, 0, screen.h - 8, global.Color.get(0, 111, 111, 111)); 
	}
}
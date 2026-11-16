function AboutMenu(parent) : Menu() constructor
{
	self.parent = parent;
	
	selected = 0; 
	
	options = [ "About Port", "About Game" ]; 

	tick = function()
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

		if (input.attack.pressed())
		{ 
			if (selected == 0)
				game.setMenu(new Port_AboutMenu(self)); 
			if (selected == 1)
				game.setMenu(new Original_AboutMenu(self)); 
		}
		if (input.menu.pressed())
			game.setMenu(parent)
	}
	
	render = function(screen)
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

function Port_AboutMenu(parent) : Menu() constructor
{
	self.parent = parent;

	tick = function()
	{
		if (input.attack.pressed() || input.menu.pressed())
			game.setMenu(parent); 
	}

	render = function(screen)
	{
		screen.clear(#0A0A0A); 
		
		var text_y = 2;
		global.Font.draw("Ported to GameMaker", screen, 2 * 0 + 4, text_y++ * 8, global.Color.get(0, 555, 555, 555)); 
		global.Font.draw("By Shelby Foltz", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 333, 333, 333)); 
		
		text_y++;
		global.Font.draw("Credits:", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 555, 555, 555)); 
		global.Font.draw("shylor/miniventure", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("Phyyl/miniventure-sharp", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("gmshaders.com", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("Markus Persson", screen, 0 * 8 + 4, text_y++ * 8, global.Color.get(0, 333, 333, 333)); 
	}
}

function Original_AboutMenu(parent) : Menu() constructor
{
	self.parent = parent;

	tick = function()
	{
		if (input.attack.pressed() || input.menu.pressed())
			game.setMenu(parent); 
	}

	render = function(screen)
	{
		screen.clear(#0A0A0A); 
		global.Font.draw("About Minicraft", screen, 2 * 8 + 4, 2 * 8, global.Color.get(0, 555, 555, 555)); 
		global.Font.draw("Minicraft was made", screen, 0 * 8 + 4, 4 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("by Markus Persson", screen, 0 * 8 + 4, 5 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("For the 22'nd ludum", screen, 0 * 8 + 4, 6 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("dare competition in", screen, 0 * 8 + 4, 7 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("december 2011.", screen, 0 * 8 + 4, 8 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("it is dedicated to", screen, 0 * 8 + 4, 9 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("my father. <3", screen, 0 * 8 + 4, 10 * 8, global.Color.get(0, 333, 333, 333)); 
	}
}
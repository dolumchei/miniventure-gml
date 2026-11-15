function singleton_Font() constructor
{
	chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ      0123456789.,!?'\"-+=/\\%()<>:;     ";
	
	static draw = function(msg, screen, xx, yy, col)
	{
		msg = string_upper(msg);
		for (var i1 = 1; i1 < string_length(msg) + 1; i1++)
		{
			var i = i1 - 1;
			var ix = string_pos(string_char_at(msg, i1), chars) - 1;
			if (ix >= 0)
				screen.render(xx + i * 8, yy, ix + 30 * 32, col, 0);
		}
	}
	
	static renderFrame = function(screen, title, x0, y0, x1, y1)
	{
		for (var yy = y0; yy <= y1; yy++)
		{
			for (var xx = x0; xx <= x1; xx++)
			{
				if (xx == x0 && yy == y0)
					screen.render(xx * 8, yy * 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
				else if (xx == x1 && yy == y0)
					screen.render(xx * 8, yy * 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 1);
				else if (xx == x0 && yy == y1)
					screen.render(xx * 8, yy * 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 2);
				else if (xx == x1 && yy == y1)
					screen.render(xx * 8, yy * 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 3);
				else if (yy == y0)
					screen.render(xx * 8, yy * 8, 1 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
				else if (yy == y1)
					screen.render(xx * 8, yy * 8, 1 + 13 * 32, global.Color.get(-1, 1, 5, 445), 2);
				else if (xx == x0)
					screen.render(xx * 8, yy * 8, 2 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
				else if (xx == x1) 
					screen.render(xx * 8, yy * 8, 2 + 13 * 32, global.Color.get(-1, 1, 5, 445), 1);
				else
					screen.render(xx * 8, yy * 8, 2 + 13 * 32, global.Color.get(5, 5, 5, 5), 1);
			}
		}

		draw(title, screen, x0 * 8 + 8, y0 * 8, global.Color.get(5, 5, 5, 550));
	}
}
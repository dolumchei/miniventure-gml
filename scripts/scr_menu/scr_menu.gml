function Menu() constructor
{
	game = undefined;
	input = undefined; 
	
	init = function(game, input)
	{
		self.game = game; 
		self.input = input; 
	}
	
	tick = function() { }

	render = function(screen) { }

	renderItemList = function(screen, xo, yo, x1, y1, listItems, selected)
	{
		var renderCursor = true;
		if (selected < 0)
		{
			selected = -selected - 1; 
			renderCursor = false; 
		}
		var w = round(x1 - xo); 
		var h = round(y1 - yo - 1); 
 		var i0 = 0; 
		var i1 = array_length(listItems); 
		if (i1 > h)
			i1 = h; 
		var io = floor(selected - h / 2); 
		if (io > array_length(listItems) - h)
			io = array_length(listItems) - h; 
		if (io < 0)
			io = 0; 

		for (var i = i0; i < i1; i++)
		{
			try { listItems[i + io].renderInventory(screen, (1 + xo) * 8, (i + 1 + yo) * 8); }
			catch (exception) // theres a bug here i cant reproduce effectively, so whenever it happens, i have this
			{
				print(instanceof(listItems[i + io]));
				show_error(exception.longMessage, false);	
			}
		}
		
		if (renderCursor)
		{
			var yy = round(selected + 1 - io + yo); 
			Font.draw(">", screen, (xo + 0) * 8, yy * 8, Color.get(5, 555, 555, 555)); 
			Font.draw("<", screen, (xo + w) * 8, yy * 8, Color.get(5, 555, 555, 555)); 
		}
	}
}

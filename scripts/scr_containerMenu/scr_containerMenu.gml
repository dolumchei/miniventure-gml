function ContainerMenu(player, title, container) : Menu() constructor
{
	self.player = player; 
	self.container = container; 
	selected = 0; 
	self.title = title; 
	oSelected = 0; 
	window = 0; 

	static tick = function()
	{
		if (input.menu.pressed())
			game.setMenu(undefined); 

		if (input.left.pressed())
		{ 
			window = 0; 
			var tmp = selected; 
			selected = oSelected; 
			oSelected = tmp; 
		}
		if (input.right.pressed())
		{ 
			window = 1; 
			var tmp = selected; 
			selected = oSelected; 
			oSelected = tmp; 
		}

		var i = window == 1 ? player.inventory : container; 
		var i2 = window == 0 ? player.inventory : container; 

		var len = array_length(i.items); 
		if (input.up.check())
			selected--; 
		if (input.down.check())
			selected++; 

		if (len == 0)
			selected = 0; 
		if (selected < 0)
			selected += len; 
		if (selected >= len)
			selected -= len; 

		if (input.attack.pressed() && len > 0)
		{ 
			var item = i.items[selected];
			i2.add(oSelected, item);
			array_delete(i.items, selected, 1);
			if (selected >= array_length(i.items))
				selected = array_length(i.items) - 1; 
		}
	}

	static render = function(screen)
	{
		if (window == 1)
			screen.setOffset(6 * 8, 0); 
		global.Font.renderFrame(screen, title, 1, 1, 12, 11); 
		renderItemList(screen, 1, 1, 12, 11, container.items, window == 0 ? selected : -oSelected - 1); 

		global.Font.renderFrame(screen, "inventory", 13, 1, 13 + 11, 11); 
		renderItemList(screen, 13, 1, 13 + 11, 11, player.inventory.items, window == 1 ? selected : -oSelected - 1); 
		screen.setOffset(0, 0); 
	}
}
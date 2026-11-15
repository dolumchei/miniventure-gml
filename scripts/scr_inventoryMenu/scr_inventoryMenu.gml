function InventoryMenu(player) : Menu() constructor 
{
	self.player = player; 
	if (player.activeItem != undefined)
	{ 
		array_insert(player.inventory.items, 0, player.activeItem); 
		player.activeItem = undefined; 
	}
	selected = 0; 

	static tick = function()
	{
		if (input.menu.pressed())
			game.setMenu(undefined); 

		if (input.up.check())
			selected--; 
		if (input.down.check())
			selected++; 

		var len = array_length(player.inventory.items); 
		if (len == 0)
			selected = 0; 
		if (selected < 0)
			selected += len; 
		if (selected >= len)
			selected -= len; 

		if (input.attack.pressed() && len > 0)
		{
			var item = player.inventory.items[selected];
			array_delete(player.inventory.items, selected, 1);
			
			player.activeItem = item; 
			game.setMenu(undefined); 
		}
	}

	static render = function(screen)
	{
		global.Font.renderFrame(screen, "inventory", 1, 1, 12, 11); 
		renderItemList(screen, 1, 1, 12, 11, player.inventory.items, selected); 
	}
}
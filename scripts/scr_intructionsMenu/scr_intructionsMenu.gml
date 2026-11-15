function InstructionsMenu(parent) : Menu() constructor
{
	self.parent = parent;
	
	static tick = function()
	{
		if (input.attack.pressed() || input.menu.pressed())
			game.setMenu(parent);  
	}

	static render = function(screen)
	{
		screen.clear(#0A0A0A); 
		global.Font.draw("HOW TO PLAY", screen, 4 * 8 + 4, 1 * 8, global.Color.get(0, 555, 555, 555)); 
		global.Font.draw("Move your character", screen, 0 * 8 + 4, 3 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("with the arrow keys", screen, 0 * 8 + 4, 4 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("press C to attack", screen, 0 * 8 + 4, 5 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("and X to open the", screen, 0 * 8 + 4, 6 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("inventory and to", screen, 0 * 8 + 4, 7 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("use items.", screen, 0 * 8 + 4, 8 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("Select an item in", screen, 0 * 8 + 4, 9 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("the inventory to", screen, 0 * 8 + 4, 10 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("equip it.", screen, 0 * 8 + 4, 11 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("Kill the air wizard", screen, 0 * 8 + 4, 12 * 8, global.Color.get(0, 333, 333, 333)); 
		global.Font.draw("to win the game!", screen, 0 * 8 + 4, 13 * 8, global.Color.get(0, 333, 333, 333)); 
	}
}

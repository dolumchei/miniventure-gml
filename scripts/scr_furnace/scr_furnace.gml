function Furnace() : Furniture("Furnace") constructor
{
	col = global.Color.get(-1, 000, 222, 333); 
	sprite = 3; 
	xr = 3; 
	yr = 2; 

	static use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(global.Crafting.furnaceRecipes, player)); 
		return true;
	}
}
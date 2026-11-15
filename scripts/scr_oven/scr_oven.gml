function Oven() : Furniture("Oven") constructor
{
	col = global.Color.get(-1, 000, 332, 442); 
	sprite = 2; 
	xr = 3; 
	yr = 2; 

	static use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(global.Crafting.ovenRecipes, player)); 
		return true;
	}
}
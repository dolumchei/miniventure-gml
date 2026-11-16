function Oven() : Furniture("Oven") constructor
{
	col = Color.get(-1, 000, 332, 442); 
	sprite = 2; 
	xr = 3; 
	yr = 2; 

	use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(Crafting.ovenRecipes, player)); 
		return true;
	}
}
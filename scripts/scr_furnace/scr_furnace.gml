function Furnace() : Furniture("Furnace") constructor
{
	col = Color.get(-1, 000, 222, 333); 
	sprite = 3; 
	xr = 3; 
	yr = 2; 

	use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(Crafting.furnaceRecipes, player)); 
		return true;
	}
}
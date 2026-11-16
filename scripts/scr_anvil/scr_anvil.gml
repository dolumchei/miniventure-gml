function Anvil() : Furniture("Anvil") constructor
{
	col = global.Color.get(-1, 000, 111, 222); 
	sprite = 0; 
	xr = 3; 
	yr = 2; 

	use2 = function(player, attackDir)
	{
		player.game.setMenu(new CraftingMenu(global.Crafting.anvilRecipes, player)); 
		return true;
	}
}
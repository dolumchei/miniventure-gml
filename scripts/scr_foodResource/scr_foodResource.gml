function FoodResource(name, sprite, color, heal, staminaCost) : singleton_Resource(name, sprite, color) constructor
{
	self.heal = heal;
	self.staminaCost = staminaCost; 

	interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		if (player.healthValue < player.maxHealth && player.payStamina(staminaCost))
		{ 
			player.heal(heal); 
			return true; 
		}
		return false; 
	}
}
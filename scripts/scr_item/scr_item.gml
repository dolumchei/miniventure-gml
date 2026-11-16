function Item() : ListItem() constructor
{
	getColor = function()
	{
		return 0;	
	}
	getSprite = function()
	{
		return 0;	
	}
	onTake = function(itemEntity) { };
	renderInventory = function(screen, xx, yy) { }
	interact = function(player, entity, attackDir)
	{
		return false;	
	}
	renderIcon = function(screen, xx, yy) { };
	interactOn = function(tile, level, xt, yt, player, attackDir) { }
	isDepleted = function()
	{
		return false;
	}
	canAttack = function()
	{
		return false;	
	}
	getAttackDamageBonus = function(e)
	{
		return 0;
	}
	getName = function()
	{
		return "";
	}
	matches = function(item)
	{
		return typeof(item) == instanceof(self);	
	}
}
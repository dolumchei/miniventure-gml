function Item() : ListItem() constructor
{
	static getColor = function()
	{
		return 0;	
	}
	static getSprite = function()
	{
		return 0;	
	}
	static onTake = function(itemEntity) { };
	static renderInventory = function(screen, xx, yy) { }
	static interact = function(player, entity, attackDir)
	{
		return false;	
	}
	static renderIcon = function(screen, xx, yy) { };
	static interactOn = function(tile, level, xt, yt, player, attackDir) { }
	static isDepleted = function()
	{
		return false;
	}
	static canAttack = function()
	{
		return false;	
	}
	static getAttackDamageBonus = function(e)
	{
		return 0;
	}
	static getName = function()
	{
		return "";
	}
	static matches = function(item)
	{
		return typeof(item) == instanceof(self);	
	}
}
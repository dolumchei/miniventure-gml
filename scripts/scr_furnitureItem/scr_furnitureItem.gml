function FurnitureItem(furniture) : Item() constructor
{
	self.furniture = furniture; 
	placed = false; 

	getColor = function()
	{
		return furniture.col;
	}
	getColor = function()
	{
		return furniture.col;
	}
	getSprite = function()
	{
		return furniture.sprite + 10 * 32;
	}
	renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0); 
	}
	renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0); 
		global.Font.draw(furniture.name, screen, xx + 8, yy, global.Color.get(-1, 555, 555, 555)); 
	}
	onTake = function(itemEntity) { }
	canAttack = function()
	{
		return false;
	}
	interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		if (tile.mayPass(level, xt, yt, furniture))
		{ 
			furniture.x = xt * 16 + 8; 
			furniture.y = yt * 16 + 8; 
			level.add(furniture); 
			placed = true; 
			return true;
		}
		return false;
	}
	isDepleted = function()
	{
		return placed;
	}
	getName = function()
	{
		return furniture.name;
	}
}
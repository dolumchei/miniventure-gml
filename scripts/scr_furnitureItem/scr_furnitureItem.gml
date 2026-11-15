function FurnitureItem(furniture) : Item() constructor
{
	self.furniture = furniture; 
	placed = false; 

	static getColor = function()
	{
		return furniture.col;
	}
	static getColor = function()
	{
		return furniture.col;
	}
	static getSprite = function()
	{
		return furniture.sprite + 10 * 32;
	}
	static renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0); 
	}
	static renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0); 
		global.Font.draw(furniture.name, screen, xx + 8, yy, global.Color.get(-1, 555, 555, 555)); 
	}
	static onTake = function(itemEntity) { }
	static canAttack = function()
	{
		return false;
	}
	static interactOn = function(tile, level, xt, yt, player, attackDir)
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
	static isDepleted = function()
	{
		return placed;
	}
	static getName = function()
	{
		return furniture.name;
	}
}
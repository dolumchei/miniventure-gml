function SpriteSheet(image) constructor
{
	self.image = image;
	width = sprite_get_width(image);
	height = sprite_get_height(image);
}
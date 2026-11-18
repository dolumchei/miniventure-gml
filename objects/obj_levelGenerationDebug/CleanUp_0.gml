for (var i = 0; i < array_last(surfaces); i++)
{
	var surface = surfaces[i];
	if (surface_exists(surface))
	{
		surface_free(surface);
		surface = -1;
	}
	surfaces[i] = surface;
}
for (var i = 0; i < array_last(buffers); i++)
{
	var buffer = buffers[i];
	if (buffer_exists(buffer))
	{
		buffer_delete(buffer);
		buffer = -1;
	}
	buffers[i] = surface;
}
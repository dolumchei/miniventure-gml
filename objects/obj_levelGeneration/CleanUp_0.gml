if (surface_exists(surface))
{
	surface_free(surface);
	surface = -1;
}
if (buffer_exists(buffer))
{
	buffer_delete(buffer);
	buffer = -1;
}
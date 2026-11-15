draw_set_alpha(1);
draw_set_color(c_white);

render();

if (surface_exists(screen.surface))
	draw_surface(screen.surface, 0, 0);
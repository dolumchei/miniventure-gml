# miniventure-gml
Minicraft port to Gamemaker based on [shylor/miniventure](https://github.com/shylor/miniventure).

---

## Added features / Todo
#### Features
- Everything has been ported, with minor bugs still needing to be found/fixed
#### Todo
- Port every class over to a respective object
- Optimization, it runs fine on my computer but ive noticed other lower-end laptops run slow

---

### Notes
- Nothing was AI generated, all port code was done by myself
- Rendering system has been changed, as drawing pixel per pixel is slow. It now uses shaders and draw_sprite_part()
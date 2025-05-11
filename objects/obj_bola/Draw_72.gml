draw_set_color(colors[bg_color]);
draw_rectangle(0,0,room_width,room_height,0);

if keyboard_check_pressed(ord("Q")){
	bg_color=!bg_color;
}
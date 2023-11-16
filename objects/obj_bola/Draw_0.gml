vy+=.45;
xxp = xx;
yyp = yy;
xx+=vx;
yy+=vy;

var _dis = point_distance(xx,yy,x,y);
var _dir = point_direction(x,y,xx,yy);
var _vdir = point_direction(0,0,vx,vy);
var _vdis = point_distance(0,0,vx,vy);

if (_dis > raio-r2) { 
	xx = x+lengthdir_x(raio-r2-1,_dir);
	yy = y+lengthdir_y(raio-r2-1,_dir);
	
	var _novo_ang = _vdir + 180 + angle_difference(180+_dir,_vdir)*2+random_range(-10,10);
	_vdis*=1.1;
	r2*=1.1;

	vx = lengthdir_x(_vdis,_novo_ang);
	vy = lengthdir_y(_vdis,_novo_ang);
}

if !surface_exists(surf) {
	surf = surface_create(room_width,room_height);
}

if keyboard_check_pressed(ord("R")){
room_restart();
}

previous_hue = hue;
if (hue++>255){
	hue = 0;
}
surface_set_target(surf);
	var _color = make_color_hsv(hue,255,255);
	var _previous_color = make_color_hsv(previous_hue,255,255);
	draw_set_colour(_color);
	/*draw_primitive_begin(pr_trianglestrip);
		var _lx = lengthdir_x(r2,_vdir-90);
		var _ly = lengthdir_y(r2,_vdir-90);
		
		draw_vertex_colour(xx+_lx,yy+_ly,_color,1);
		draw_vertex_colour(xx-_lx,yy-_ly,_color,1);
		draw_vertex_colour(xxp+_lx,yyp+_ly,_previous_color,1);
		draw_vertex_colour(xxp-_lx,yyp-_ly,_previous_color,1);
	draw_primitive_end();
	*/
	draw_circle(xx,yy,r2,0);
surface_reset_target();

draw_surface(surf,0,0);
draw_set_colour(c_white);
draw_circle(x,y,raio,1);
	draw_circle(xx,yy,r2,0);


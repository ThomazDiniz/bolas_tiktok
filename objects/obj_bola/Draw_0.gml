var _mouse_r_clicking	= mouse_check_button(mb_right);
var _mouse_r_click		= mouse_check_button_pressed(mb_right);
var _mouse_r_clicked	= mouse_check_button_released(mb_right);

var _dis = point_distance(xx,yy,x,y);
var _dir = point_direction(x,y,xx,yy);
var _vdir = point_direction(0,0,vx,vy);
var _vdis = point_distance(0,0,vx,vy);
var _r2 =  r2*scale;
var _w = sprite_get_width(spr_bola)*scale/2;
var _h = sprite_get_height(spr_bola)*scale/2;

if (!global.pause && !_mouse_r_clicking) {
	vy+=.45;
	xxp = xx;
	yyp = yy;
	xx+=vx;
	yy+=vy;
}



#region Colisão

	var _colidiu = 0;
	switch(global.tipo_de_limite){
		case tipo_de_limites_enum.circulo:
			if (_dis > raio-_r2) { 
				var _novo_ang = _vdir + 180 + angle_difference(180+_dir,_vdir)*2;
				_colidiu = 1
				vx = lengthdir_x(_vdis,_novo_ang);
				vy = lengthdir_y(_vdis,_novo_ang);
			}
			draw_set_color(colors[!bg_color]);
				draw_circle(x,y,raio-1,1);
		break;
		
		case tipo_de_limites_enum.retangulo:
			if (xx-_w/2<x-w || xx+_w/2>x+w){
				vx=-vx;
				_colidiu = 1;
			}
			
			if (yy-_h/2<y-h || yy+_h/2>y+h){
				vy=-vy;
				_colidiu = 1;
			}
			
			draw_set_color(colors[!bg_color]);
				draw_rectangle(x-w,y-h,x+w,y+h,1);
		break;
	}
	
	if (_colidiu) {
		sound_play(global.snd,1,pitches[pitches_index],2);
		//sound_play(sfx_batida);
		pitches_index++;
		if pitches_index >= array_length(pitches){
			pitches_index = 0;
		}
		switch(global.tipo_de_comportamento){
			case comportamento_de_bola_enum.nada:
			break;
		
			case comportamento_de_bola_enum.cresce_e_acelera:
				vx*=1.1;
				vy*=1.1;
				scale*=1.1;
			break;
		
			case comportamento_de_bola_enum.acelera:
				vx*=1.05;
				vy*=1.05;
			break;
		
			case comportamento_de_bola_enum.cresce:
				scale*=1.1;
			break;
		}
		switch(global.tipo_de_limite){
			case tipo_de_limites_enum.retangulo:
				_w = sprite_get_width(spr_bola)*scale/2;
				_h = sprite_get_height(spr_bola)*scale/2;
				xx = clamp(xx,x-w+_w/2,x+w-_w/2);
				yy = clamp(yy,y-h+_h/2,y+h-_h/2);
			break;
			
			case tipo_de_limites_enum.circulo:
				_r2 = r2*scale;
				xx = x+lengthdir_x(raio-_r2-1,_dir);
				yy = y+lengthdir_y(raio-_r2-1,_dir);
			break;
		}
	}
#endregion
draw_set_colour(c_white);
if !surface_exists(surf) {
	surf = surface_create(room_width,room_height);
}

if keyboard_check_pressed(ord("R"))	{global.i=0; room_restart();}
if keyboard_check_pressed(vk_up)	{change_bola();}
if keyboard_check_pressed(vk_down)	{change_comportamento();}
if keyboard_check_pressed(vk_left)	{change_rastro();}
if keyboard_check_pressed(vk_right)	{change_limites();}
if keyboard_check_pressed(vk_space)	{global.pause = !global.pause;}

previous_hue = hue;
if (hue++>255){
	hue = 0;
}
surface_set_target(surf);
	var _color = make_color_hsv(hue,255,255);
	var _previous_color = make_color_hsv(previous_hue,255,255);
	draw_set_colour(_color);
	image_blend = _color;
	switch(global.tipo_de_rastro){
		case tipo_de_rastro_enum.proprio_desenho:
			desenha_proprio_desenho_pintado();
		break;
		
		case tipo_de_rastro_enum.proprio_desenho_pintado:
			desenha_proprio_desenho_pintado(_color);
		break;
		
		case tipo_de_rastro_enum.rastro_pintado:
			draw_primitive_begin(pr_trianglestrip);
				var _lx = lengthdir_x(_r2,_vdir-90);
				var _ly = lengthdir_y(_r2,_vdir-90);
		
				draw_vertex_colour(xx+_lx,yy+_ly,_color,1);
				draw_vertex_colour(xx-_lx,yy-_ly,_color,1);
				draw_vertex_colour(xxp+_lx,yyp+_ly,_previous_color,1);
				draw_vertex_colour(xxp-_lx,yyp-_ly,_previous_color,1);
			draw_primitive_end();
		break;
	}
surface_reset_target();

if !surface_exists(surf_limite){
	surf_limite = surface_create(room_width,room_height);
}
surface_set_target(surf_limite);
draw_clear(c_black);
draw_set_color(c_white);
	switch(global.tipo_de_limite){
		case tipo_de_limites_enum.circulo:
			draw_circle(x,y,raio,0);
		break;
			
		case tipo_de_limites_enum.retangulo:
			draw_rectangle(x-w,y-h,x+w,y+h,0);
		break;
	}
surface_reset_target();

surface_set_target(surf);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_surface(surf_limite,0,0);
	gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface(surf,0,0);

desenha_proprio_desenho_pintado(c_white);

draw_text(10,10,
			string("Bola: {0}\nComportamento:{1}\nlimite:{2}\nrastro:{3}",
				tipo_de_bola_str[global.tipo_de_bola],
				comportamento_de_bola_str[global.tipo_de_comportamento],
				tipo_de_limites_str[global.tipo_de_limite],
				tipo_de_rastro_str[global.tipo_de_rastro]
			)
		);

var _fx = (mouse_x-rmx);
var _fy = (mouse_y-rmy);

if (_mouse_r_clicked){
	vx = _fx*.3;
	vy = _fy*.3;
}
if (_mouse_r_clicking){
	draw_line_width(xx,yy,xx+_fx,yy+_fy,5);
} else {
	rmx = mouse_x;
	rmy = mouse_y;
}


var _mouse_wheel = mouse_wheel_up() - mouse_wheel_down();

scale+=_mouse_wheel*.2;
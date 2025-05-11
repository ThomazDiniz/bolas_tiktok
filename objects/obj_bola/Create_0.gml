surf = -1;
surf_limite = -1;
raio = 256;
x = room_width/2;
y = room_height/2;

xx = x-125;
yy = y;
vx = random_range(-3,3);
vy = 0;
r2 = 8;
scale = 1;
w = 128;
h = 256;
xxp = xx;
yyp = yy;

previous_hue = 0;
hue = 0;
pitches = [1,1.1,1.2,1.3,1.4,1.5,1.6]
pitches_index = 0;

randomize();


enum tipo_de_bola_enum {
	bola,sprite_0,sprite_1,sprite_s
}

tipo_de_bola_str = ["bola","sprite_0","sprite_1","importado"];

enum comportamento_de_bola_enum {
	nada,cresce,acelera,cresce_e_acelera
}
comportamento_de_bola_str = ["nada","cresce","acelera","cresce_acelera"];

enum tipo_de_limites_enum {
	circulo,retangulo
}
tipo_de_limites_str = ["circulo","retangulo"];

enum tipo_de_rastro_enum {
	proprio_desenho_pintado,proprio_desenho,rastro_pintado
}
tipo_de_rastro_str = ["desenho_pintado","desenho","rastro_pintado"];


function desenha_proprio_desenho_pintado(_color = c_white){
	draw_set_colour(_color);
	switch(global.tipo_de_bola){
		case tipo_de_bola_enum.bola:
			draw_circle(xx,yy,r2*scale,0);
		break;
		
		case tipo_de_bola_enum.sprite_0:
			draw_sprite_ext(spr_bola,0,xx,yy,scale,scale,image_angle,_color,1);
		break;
		
		case tipo_de_bola_enum.sprite_1:
			draw_sprite_ext(spr_bola,1,xx,yy,scale,scale,image_angle,_color,1);
		break;
		
		case tipo_de_bola_enum.sprite_s:
			draw_sprite_ext(global.spr,0,xx,yy,scale*global.special_scale,scale*global.special_scale,image_angle,_color,1);
		break;
	}
}
draw_set_circle_precision(64);


rmx = mouse_x;
rmy = mouse_x;

colors = [c_black,c_white];
bg_color = 0;
draw_set_font(fnt);


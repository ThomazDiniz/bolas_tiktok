surf = -1;
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

previous_hue = 0;
hue = 0;
pitches = [1,1.1,1.2,1.3,1.4,1.5,1.6]
pitches_index = 0;

randomize();

function change_bola(){
	if ++global.tipo_de_bola > tipo_de_bola_enum.sprite_1{
		global.tipo_de_bola = 0;
	}
}	

function change_limites(){
	if ++global.tipo_de_limite > tipo_de_limites_enum.retangulo{
		global.tipo_de_limite = 0;
	}
}	

function change_rastro(){
	if ++global.tipo_de_rastro > tipo_de_rastro_enum.rastro_pintado{
		global.tipo_de_rastro = 0;
	}
}	
function change_comportamento(){
	if ++global.tipo_de_comportamento > comportamento_de_bola_enum.cresce {
		global.tipo_de_comportamento = 0;
	}
}	

enum tipo_de_bola_enum {
	bola,sprite_0,sprite_1
}

enum comportamento_de_bola_enum {
	nada,cresce,acelera,cresce_e_acelera
}

enum tipo_de_limites_enum {
	circulo,retangulo
}

enum tipo_de_rastro_enum {
	proprio_desenho_pintado,proprio_desenho,rastro_pintado
}



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
			draw_sprite_ext(spr_bola,0,xx,yy,scale,scale,image_angle,_color,1);
		break;
	}
}
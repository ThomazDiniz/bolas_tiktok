function sound_play(_snd,_vol=1,_pitch=1,_multiple=1,_loops=0,_priority=1){
	switch(_multiple){
		case 0: //cant play multiple
			if (audio_is_playing(_snd)){
				return _snd;// todo(tumais) - tratar melhor esse erro
			}
		break;
			
		case 1://can play multiple
		break;
			
		case 2://overlap
			if (audio_is_playing(_snd)) {
				audio_stop_sound(_snd);
			}
		break;
	}
		
	var snd = audio_play_sound(_snd,_priority,_loops,_vol,0,_pitch);
	return snd;
}


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
	if ++global.tipo_de_comportamento > comportamento_de_bola_enum.cresce_e_acelera {
		global.tipo_de_comportamento = 0;
	}
}	

	global.special_scale = 1;
function load_sprite() {
	var _path = get_open_filename_ext("*.png", "", "", "imagem");
	global.spr = sprite_add(_path,1,0,0,0,0);
	var _w = sprite_get_width(global.spr);
	var _h = sprite_get_height(global.spr);
	sprite_set_offset(global.spr,_w/2,_h/2);
	global.tipo_de_bola = tipo_de_bola_enum.sprite_s;
	global.special_scale = 16/min(_w,_h);
	
}	

function load_sfx(){
	var _path = get_open_filename_ext("*.ogg", "", "", "som no formato ogg");
	global.snd = audio_create_stream(_path);
	audio_play_sound(global.snd, 0, 0);
}	

global.tipo_de_bola				= 0;
global.tipo_de_limite			= 0;
global.tipo_de_rastro			= 0;
global.tipo_de_comportamento	= 0;
global.pause					= 0;
global.i						= 0;
global.spr						= spr_bola;
global.snd						= sfx_batida;
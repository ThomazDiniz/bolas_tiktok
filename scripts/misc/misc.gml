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


global.tipo_de_bola = tipo_de_bola_enum.bola;
global.tipo_de_limite = tipo_de_limites_enum.circulo;
global.tipo_de_rastro = tipo_de_rastro_enum.proprio_desenho_pintado;
global.tipo_de_comportamento = comportamento_de_bola_enum.cresce;
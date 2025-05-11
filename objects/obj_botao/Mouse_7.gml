image_blend = c_white;
switch(i){
	case 0: global.pause = !global.pause;	break;
	case 1: change_bola();	break;
	case 2: change_comportamento();	break;
	case 3: change_rastro();	break;
	case 4: change_limites();	break;
	case 5: load_sprite();	break;
	case 6: load_sfx();	break;
	case 7: url_open("https://www.youtube.com/@acidente_dev?sub_confirmation=1"); break;
}
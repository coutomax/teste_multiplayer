function collisions(inst){

    var _x = inst.x;
    var _y = inst.y;
    
    var _move	= inst.data.move;
    var _flags   = inst.data.flags;
    var _next_x = _x + _move.xspd;
	var _next_y = _y + _move.yspd;
    
    var _sprite_width	= inst.sprite_width;
	var _sprite_height	= inst.sprite_height;
    
    var _pixel_check_x  = sign(_move.xspd);
	var _pixel_check_y  = sign(_move.yspd);		
	var _y_check        = _y + _pixel_check_y;
	var _x_check        = _x + _pixel_check_x;
    var _sub_pixel      = .5;
    
    // colisão vertical
    if (_move.yspd != 0)
    {
        if (place_meeting(_x, _next_y, obj_wall))
        {
            var _safety_loop = 0;
            while (!place_meeting(_x, _y_check, obj_wall))
            {
                _y			+= _pixel_check_y;
				_y_check	= _y + _pixel_check_y;
				inst.y 		= _y;

				_safety_loop++;
				if (_safety_loop > 32) break;
            }
            _move.yspd = 0;
            _flags.on_ground = true;
        }
        else {
        	_flags.on_ground = false;
        }
    }
    
    //colisão horizontal
    if (_move.xspd != 0)
    {
        if (place_meeting(_next_x, _y, obj_wall))
        {
            var _pixel_check	= _sub_pixel * sign(_move.xspd);
            var _safety_loop	= 0;
            
            while(!place_meeting(_x + _pixel_check, _y, obj_wall))
            {
                _x				+= _pixel_check;
                inst.x			= _x;

                _safety_loop++;
                if (_safety_loop > 32) break;
            }
            _move.xspd		= 0;
        }
    }
    
    
    //limite da tela
    if (_next_x < 0 + _sprite_width / 2 or _next_x > room_width - _sprite_width / 2)
    {
        _move.xspd = 0;
    }
    
    if (_next_y < 0 + _sprite_height / 2 or _next_y > room_height - _sprite_height / 2)
    {
        _move.yspd = 0;
    }
}
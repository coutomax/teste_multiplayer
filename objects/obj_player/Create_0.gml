h_input     = 0;
jump_input  = 0;
shoot_input = 0;

grav        = global.gravity;

owner_socket      = noone;

data    =
{
    move:
    {
        xspd : 0,
        yspd : 0,
        default_spd : 2,
        jump :
        {
            jump_spd    : -5,
            jump_count  : 0,
            jump_max    : 2
        }
    },
    
    attack:
    {
      attack_cd : 0,
      cd_count  : 0
    },
    
    flags:
    {
        alive       : true,
        on_ground   : false,
    }
}

movement = function()
{
    h_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    jump_input = keyboard_check_pressed(vk_space);
    
    data.move.yspd += grav;
    
    if (h_input != 0)
    {
        data.move.xspd = data.move.default_spd * h_input;
    }
    else 
    {
        data.move.xspd = 0;
    }
    
    #region pulo
    if (jump_input && (data.flags.on_ground || data.move.jump.jump_count < 1))
    {
        data.move.yspd = data.move.jump.jump_spd;
        data.move.jump.jump_count++;
    }
    
    if (data.flags.on_ground)
    {
        data.move.jump.jump_count = 0;
    }
    #endregion
    
    collisions(id);

    x += data.move.xspd;
    y += data.move.yspd;
    
    obj_network_client.network_walk(x, y);
}

shoot = function()
{
    shoot_input = mouse_check_button_pressed(mb_left);
    
    if (shoot_input && data.attack.cd_count == 0)
    { 
        /*
        var _attack = instance_create_layer(x, y, "Instances", obj_projectile);
        var _dir	= point_direction(_attack.x, _attack.y, mouse_x, mouse_y);
		
		_attack.data.move.xspd	= lengthdir_x(_attack.data.move.xspd, _dir);
		_attack.data.move.yspd	= lengthdir_y(_attack.data.move.yspd, _dir);
        
        _attack.direction 		= _dir;
        _attack.image_angle     = _dir - 90;
        
        */
        
        obj_network_client.network_shoot(mouse_x, mouse_y);
        
        data.attack.cd_count = data.attack.attack_cd;
    }
    
    if (data.attack.cd_count > 0)
    {
        data.attack.cd_count--;
    }
}


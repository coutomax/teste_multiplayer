grav    = global.gravity;

owner   = noone;

data    =
{
    move:
    {
        xspd : 12,
        yspd : 12,
    },
    
    physics:
    {
        restitution : 0.4,
    },
    
    flags:
    {
        on_ground : false
    }
}

movement = function()
{
    data.move.yspd += grav;

    projectile_collision();
        
    var _new_dir    = point_direction(0, 0,data.move.xspd, data.move.yspd);
    
    if (data.move.xspd != 0)
    {
        image_angle     = _new_dir - 90;
    }
    
    if (data.move.xspd == 0 && data.move.yspd == 0)
    {
        image_angle = round(image_angle / 90) * 90;
    }
    
    x += data.move.xspd;
    y += data.move.yspd;
}

projectile_collision = function()
{
    //colisão horizontal
    if (place_meeting(x + data.move.xspd, y, [obj_wall, obj_projectile]))
    {
        var _safety_loop = 0;
        var _pixel_check_x = sign(data.move.xspd);
        while(!place_meeting(x + _pixel_check_x, y, [obj_wall, obj_projectile]))
        {
            x += _pixel_check_x;
            _safety_loop++; 
            if (_safety_loop > 16) break;
        }
        data.move.xspd = -data.move.xspd * data.physics.restitution;
    }
    
    //colisão vertical
    if (place_meeting(x, y + data.move.yspd, [obj_wall, obj_projectile]))
    {
        var _safety_loop = 0;
        var _pixel_check_y = sign(data.move.yspd);
        while(!place_meeting(x, y + _pixel_check_y, [obj_wall, obj_projectile]))
        {
            y += _pixel_check_y;
            
            _safety_loop++; 
            if (_safety_loop > 16) break;
        }
        data.move.yspd = -data.move.yspd * data.physics.restitution;
        
        if (abs(data.move.xspd) < 1)
        {
            data.move.xspd = 0;
        }
        
        if (abs(data.move.yspd) < 0.4)
        {
            data.move.yspd = 0;
        }
    }
}
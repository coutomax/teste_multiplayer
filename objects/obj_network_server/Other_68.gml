var _id = async_load[? "id"];
var _type = async_load[? "type"];

if (server == _id)
{
    if (_type == network_type_connect)
    {
        var _socket = async_load[? "socket"];
        var _instance = instance_create_layer(50, 50, "Instances", obj_player);
        _instance.socket = _socket;
        
        ds_map_add(ds_clients, _socket, _instance);
    }
    else if (_type == network_type_disconnect){
        
    	var _socket = async_load[? "socket"];
        var _instance = ds_clients[? _socket];
        
        disconnect(id, _instance.socket);
        
        instance_destroy(_instance);
        ds_map_delete(ds_clients, _socket);
    }
}
else {
	var _socket = async_load[? "id"];
    var _buffer     = async_load[? "buffer"];
    var _message    = buffer_read(_buffer, buffer_string);
    var _instance   = ds_clients[? _socket];
    
    switch (_message)
    {
        case "player_update":
            var _x = buffer_read(_buffer, buffer_s16);
            var _y = buffer_read(_buffer, buffer_s16);
            
            _instance.x = _x;
            _instance.y = _y;
        break;
        
        case "bullet_create": 
            var _mx = buffer_read(_buffer, buffer_s16);
            var _my = buffer_read(_buffer, buffer_s16);
             
            var _attack = instance_create_layer(_instance.x, _instance.y, "Instances", obj_projectile);
            var _dir	= point_direction(_instance.x, _instance.y, _mx, _my);
  		
     		_attack.data.move.xspd	= lengthdir_x(_attack.data.move.xspd, _dir);
     		_attack.data.move.yspd	= lengthdir_y(_attack.data.move.yspd, _dir);
          
            _attack.direction 		= _dir;
            _attack.image_angle     = _dir - 90;
            
            _attack.owner = _instance;
        
            ds_map_add(ds_projectiles, _socket, _attack);
            
        break;
    }
}
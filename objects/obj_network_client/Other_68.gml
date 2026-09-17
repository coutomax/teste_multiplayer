var _buffer = async_load[? "buffer"];
var _message = buffer_read(_buffer, buffer_string);

switch (_message)
{
    case "send_client":
        var _player_count = buffer_read(_buffer, buffer_s16);
    
        for (var i = 0; i< _player_count; i++)
        {
            var _socket = buffer_read(_buffer, buffer_s16);
            var _x = buffer_read(_buffer, buffer_s16);
            var _y = buffer_read(_buffer, buffer_s16);
           
            if (!ds_map_exists(ds_players, _socket))
            {
               var _instance       = instance_create_layer(_x, _y, "Instances", obj_player_render);
               ds_map_add(ds_players, _socket, _instance);
            }
            else 
            {
         	    var _instance = ds_players[? _socket];
                _instance.x     = _x;
                _instance.y     = _y;
            }
        }
        break;
    
    case "disconnected":
        var _socket = buffer_read(_buffer, buffer_s16);
    
        if (ds_map_exists(ds_players, _socket))
        {
            var _instance = ds_players[? _socket];
            
            instance_destroy(_instance);
            ds_map_delete(ds_players, _socket);
        }
        break;
}

if (_message == "disconnected")
{
    
}
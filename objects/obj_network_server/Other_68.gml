var _id = async_load[? "id"];
var _type = async_load[? "type"];

if (server == _id)
{
    if (_type == network_type_connect)
    {
        show_message("CONECTOU");
        var _socket = async_load[? "socket"];
        var _instance = instance_create_layer(50, 50, "Instances", obj_player);
        _instance.socket = _socket;
        
        ds_map_add(ds_clients, _socket, _instance);
    }
    else if (_type == network_type_disconnect){
        show_message("DESCONECTOU");
        
    	var _socket = async_load[? "socket"];
        var _instance = ds_clients[? _socket];
        
        disconnect(id, _instance.socket);
        
        instance_destroy(_instance);
        ds_map_delete(ds_clients, _socket);
    }
}
else {
	var _socket = async_load[? "id"];
    
    var _instance       = ds_clients[? _socket];
    var _buffer         = async_load[? "buffer"];
    var _read_buffer    = buffer_read(_buffer, buffer_string);
    
    if (_read_buffer == "Atualizar_Player")
    {
        var _x = buffer_read(_buffer, buffer_s16);
        var _y = buffer_read(_buffer, buffer_s16);
        
        show_debug_message("Atualizando player para: " + string(_x) + ", " + string(_y));

        _instance.x = _x;
        _instance.y = _y;
    }
    
}
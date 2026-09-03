function disconnect(inst, disconected_socket)
{ 
    var _clients    = inst.ds_clients;
   for (var i = ds_map_find_first(_clients); !is_undefined(i); i = ds_map_find_next(_clients, i))
   {
        var _instance   = _clients[? i];
        
        if (disconected_socket != _instance.socket)
        { 
            var _buffer     = inst.buffer;
            
            buffer_seek(_buffer, buffer_seek_start, 0);
            buffer_write(_buffer, buffer_string, "disconnected");
            buffer_write(_buffer, buffer_s16, disconected_socket);
          
            network_send_packet(_instance.socket,_buffer, buffer_tell(_buffer));
        }
   }
}
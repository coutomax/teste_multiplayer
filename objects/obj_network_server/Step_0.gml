for (var i = ds_map_find_first(ds_clients); !is_undefined(i); i = ds_map_find_next(ds_clients, i))
{
    instance = ds_clients[? i];
    
    //dados para repassar ao client
    var _num_players    = instance_number(obj_player) - 1;
    
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "send_client");
    buffer_write(buffer, buffer_s16, _num_players);
    
    with (obj_player)
    {
        if (other.instance.socket != socket)
        { 
            buffer_write(other.buffer, buffer_s16, socket);
            buffer_write(other.buffer, buffer_s16, x);
            buffer_write(other.buffer, buffer_s16, y);
        } 
    }
    
    network_send_packet(instance.socket, buffer, buffer_tell(buffer));
}
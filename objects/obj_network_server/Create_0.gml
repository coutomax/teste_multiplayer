server = network_create_server(network_socket_tcp, 25556, 8);

ds_clients = ds_map_create();
ds_projectiles = ds_map_create();

buffer = buffer_create(1024, buffer_grow, 1);

data_return = function (_inst, _data_struct, _tag)
{
    for (var i = ds_map_find_first(_data_struct); !is_undefined(i); i = ds_map_find_next(_data_struct, i))
    {
        instance = _data_struct[? i];
        
        //dados para repassar ao client
        var _num_instances    = instance_number(_inst) - 1;
        
        buffer_seek(buffer, buffer_seek_start, 0);
        buffer_write(buffer, buffer_string, "_tag");
        buffer_write(buffer, buffer_s16, _num_instances);
        
        with (_inst)
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
}
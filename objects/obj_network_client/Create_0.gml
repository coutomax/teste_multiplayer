tcp     = network_create_socket(network_socket_tcp);
socket  = network_connect(tcp, "192.168.3.7", 25556);
buffer  = buffer_create(1024, buffer_grow, 1);

ds_players      = ds_map_create();
ds_projectiles  = ds_map_create();

function network_shoot(_mx, _my)
{
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "bullet_create");
    buffer_write(buffer, buffer_s16, _mx);
    buffer_write(buffer, buffer_s16, _my);
    network_send_packet(socket, buffer, buffer_tell(buffer));
}

function network_move_bullet (_x, _y)
{
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "bullet_update");
    buffer_write(buffer, buffer_s16, _x);
    buffer_write(buffer, buffer_s16, _y);
}

function network_walk(_x, _y)
{
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "player_update");
    buffer_write(buffer, buffer_s16, _x);
    buffer_write(buffer, buffer_s16, _y);
    network_send_packet(socket, buffer, buffer_tell(buffer));
}
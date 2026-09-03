    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "Atualizar_Player");
    buffer_write(buffer, buffer_s16, obj_player.x);
    buffer_write(buffer, buffer_s16, obj_player.y);
    network_send_packet(socket, buffer, buffer_tell(buffer));
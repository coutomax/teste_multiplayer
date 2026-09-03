server = network_create_server(network_socket_tcp, 25556, 8);

ds_clients = ds_map_create();

buffer = buffer_create(1024, buffer_grow, 1);
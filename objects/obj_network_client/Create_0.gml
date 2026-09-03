tcp = network_create_socket(network_socket_tcp);
socket = network_connect(tcp, "192.168.3.7", 25556);
buffer = buffer_create(1024, buffer_grow, 1);

ds_players = ds_map_create();
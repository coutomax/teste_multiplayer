function button_actions(obj, actions){
    var _a =
    {
        object			: obj,
		action			: actions,
		obj_layer		: noone,
		
		on_create		:	function ()
		{
			obj_layer	= layer_get_name(self.object.layer);
		},
		
		on_activate		: function ()
		{
            switch (action)
			{
                case "host":
                    room_goto(1);
                    layer_set_visible("ui_start_menu", false);
                break;
                
                case "client":
                    room_goto(2);
                    layer_set_visible("ui_start_menu", false);
                break;
            }
        }
    }
    return _a;
}
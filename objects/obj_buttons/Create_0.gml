escalaX     = image_xscale;
escalaY     = image_yscale;

xscale      = escalaX;
yscale      = escalaY;

active      = button_actions(id, actions);
active.on_create();

reset = function()
{
    image_index = 0;
}
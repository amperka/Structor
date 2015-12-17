$fn=16;

inerface_filename = "dc_motor_encoder_2x7.dxf";

module structor_interface();
{
    base_len=5;
    grav1=1.5;
    grav2=2.5;

difference() {
    linear_extrude(base_len)
    difference()
{
import (file = inerface_filename, layer = "0");
import (file = inerface_filename, layer = "holes");

};

union()
{
    translate([0,0,base_len-grav1])
    linear_extrude(grav1)
import (file = inerface_filename, layer = "grav1.5mm");
    translate([0,0,base_len-grav2])
    linear_extrude(grav2)
import (file = inerface_filename, layer = "grav2.5mm");

    
    
}
}
}
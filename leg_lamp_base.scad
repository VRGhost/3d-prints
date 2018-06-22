$fn=600;

epsilon=0.0001;
in_leg_hole_d = 21;
plug_top_d = 40-0.6;
plug_cylinder_base_h = 2;
plug_cylinder_top_h = 16;
leg_base_depth=90;

lamp_base_d=12;
lamp_base_h=25.3;

leg_plug_width = 5.4;
leg_plug_depth = 3;
leg_plug_notch_d = 2*0.75;

// Gentle top cap curve
leg_plug_raise_h = 4;

module leg_plug_notch() {
    leg_plug_h = 2*plug_cylinder_top_h;
    
    translate([-leg_plug_width/2, 0, -plug_cylinder_top_h/2])
    difference()
    {
        translate([0,-leg_plug_depth,0])
        cube([leg_plug_width, 2*leg_plug_depth, leg_plug_h]);
        
        translate([0, 0, -epsilon])
        cylinder(d=leg_plug_notch_d, h=leg_plug_h + 2*epsilon);
        
        translate([leg_plug_width, 0, -epsilon])
        cylinder(d=leg_plug_notch_d, h=leg_plug_h + 2*epsilon);
    }
}

module orig_leg_plug_top() {
    // xy slice
    in_leg_plug_r = plug_top_d/2;
    triangle_angle = atan(
        (plug_cylinder_top_h - plug_cylinder_base_h) /
        plug_top_d
    );
    
    triangle_extra_length = 17;
    
    intersection()
    {
        color("green")
        translate([0,2*plug_top_d,0])
        rotate([90,0,0])
        linear_extrude(height=4*plug_top_d)
            polygon([
                [-in_leg_plug_r, 0],
                [-in_leg_plug_r, plug_cylinder_base_h],
                [in_leg_plug_r + triangle_extra_length, plug_cylinder_base_h + tan(triangle_angle) * (plug_top_d + triangle_extra_length)],
                [in_leg_plug_r + triangle_extra_length, 0]
            ]);
        
        union()
        {
            cylinder(plug_cylinder_top_h, d=plug_top_d);
            translate([ plug_top_d/2, 0, 0])
            rotate([0, 0, -90])
                leg_plug_notch();
        }
     
        
        raise_r = leg_plug_raise_h / 2 + pow(plug_top_d, 2) / ( 8 * leg_plug_raise_h );
        
        color("gray")
        translate([0,0,-raise_r + plug_cylinder_base_h + 3])
        rotate([0,90-triangle_angle,0])
            cylinder(h=4*plug_top_d, r=raise_r, center=true);
    }
}

landing_pad_z = plug_cylinder_top_h*0.73;

module orig_leg_plug() {
    union()
    {
        orig_leg_plug_top();
        // The shaft
        shaft_h = min(
            leg_base_depth,
            (lamp_base_h - landing_pad_z) * 1.1
        );
        
        translate([0,0,-shaft_h])
        cylinder(d=in_leg_hole_d, h=shaft_h+epsilon);
    }
}

module lamp_insert() {
    translate([0,0, -lamp_base_h])
        cylinder(d=lamp_base_d, h=lamp_base_h+epsilon);
}


difference()
{
    union()
    {
        orig_leg_plug();
        // lamp landing pad
        translate([0,0, landing_pad_z])
        translate([0,0, -lamp_base_h])
        cylinder(d=lamp_base_d+8, h=lamp_base_h);
    }

    color("red")
    translate([0,0, landing_pad_z+epsilon])
    lamp_insert();
}
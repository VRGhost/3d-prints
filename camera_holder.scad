// Camera base
//cube([45, 50, 48]);

// Monitor
module monitor() {
    width=300;
    height=100;
    monitor_thickness=40;
    
    translate([-50, 0,0])
       rotate([270, 0, 0]) {

            union() {
                cube([width, height+45, monitor_thickness]);
                translate([0, 45, 38])
                    cube([width, height, 70]);
            }
        };
}

// Camera base
module camera() {
    external_width=43-3;
    internal_depth=50;
    leg_height=57.5;
    plastic_thickness=3;
    max_widtdh=200;
    front_lip_h=12;
    
    over=10;
    
    translate([-over/2, -plastic_thickness, plastic_thickness])
    translate([external_width, internal_depth, 0])
    rotate([270, 0,180])
    difference() {
        // external box
    color("blue")
        translate([0,0, -plastic_thickness])
        cube([external_width+2*plastic_thickness,  leg_height, internal_depth + 2*plastic_thickness]);
        
    // internal box
    
    color("red")
    translate([-over/2, plastic_thickness, 0])
        cube([external_width+2*over, leg_height + plastic_thickness, internal_depth]);
    
    
    // front lip box
    difference() {
    color("cyan")
        translate([-1, plastic_thickness, internal_depth/2])
            cube([max_widtdh+2*over, leg_height + plastic_thickness, internal_depth]);
        color("green")
            translate([-over, plastic_thickness-1, internal_depth/2])
            cube([max_widtdh+2*over, front_lip_h+1, max_widtdh]);
    }
    }
}

module camera_adaptor() {
}


// mount



//color("purple")

difference() {
    
translate([-28.5,-5,-84])
difference() 
    {
    width=54-3;
        depth=50;
    cube([width,depth+2,100]);
    translate([-1,-10, -25])
    cube([width+2,depth+2,100]);
}

color("gray", 1.0)
    monitor();

color("blue")
translate([-15,-1,15])
camera();
}
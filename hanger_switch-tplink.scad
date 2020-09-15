use <modules/fixing.scad>
use <modules/shapes.scad>

rounding_mm = 2;
thickness_mm = 5;
overlap_length_mm = 4;

switch_width_mm = 100.0; // 100+0.1 = 99.8 measured
switch_depth_mm = 98.6;
switch_height_mm = 25.7; // 26+0.1 = 25.85 measured
play_mm = 0.3;
back_holes_diam_mm = 15;
back_holes_z_count = 3;
back_holes_x_count = 3;

actual_width_mm = switch_width_mm + play_mm;
actual_depth_mm = switch_depth_mm + play_mm;
actual_height_mm = switch_height_mm + play_mm;

inner_width_mm = actual_depth_mm;
inner_height_mm = actual_width_mm;
inner_depth_mm = actual_height_mm;
outer_width_mm = inner_width_mm + 2*thickness_mm;
outer_depth_mm = inner_depth_mm + 2*thickness_mm;
outer_height_mm = inner_height_mm + thickness_mm;

module hanger() {
    inner_kernel_width_mm = inner_width_mm - 2*rounding_mm;
    outer_kernel_width_mm = outer_width_mm - 2*rounding_mm;
    inner_kernel_depth_mm = inner_depth_mm - 2*rounding_mm;
    outer_kernel_depth_mm = outer_depth_mm - 2*rounding_mm;
    //inner_kernel_height_mm = inner_height_mm - rounding_mm;
    outer_kernel_height_mm = outer_height_mm - rounding_mm;
    overlap_kernel_length_mm = overlap_length_mm - rounding_mm;

    minkowski() {
        $fn = 12; // no need for many facets here
      difference() {
       translate([0, 0, rounding_mm])
        union() {
            linear_extrude(outer_kernel_height_mm)
            // extrusion base
            difference() {
                translate([-outer_kernel_width_mm/2,rounding_mm])
                    square([outer_kernel_width_mm, outer_kernel_depth_mm]);
                translate([-(inner_width_mm+2*rounding_mm)/2,thickness_mm-rounding_mm])
                    square([inner_width_mm+2*rounding_mm, inner_depth_mm+2*rounding_mm]);
                translate([-inner_width_mm/2 + overlap_kernel_length_mm, thickness_mm+rounding_mm, 0])
                    square([inner_width_mm - 2*overlap_kernel_length_mm, outer_kernel_depth_mm]);
            }

            // lower overlap
            lower_overlap_width_mm = thickness_mm + overlap_length_mm - 2*rounding_mm;
            translate([outer_kernel_width_mm/2-lower_overlap_width_mm,rounding_mm,0])
                cube([lower_overlap_width_mm, outer_kernel_depth_mm, thickness_mm-2*rounding_mm]);
            translate([-outer_kernel_width_mm/2,rounding_mm,0])
                cube([lower_overlap_width_mm, outer_kernel_depth_mm, thickness_mm-2*rounding_mm]);

        }

        // side holes
        hole_width_mm = inner_depth_mm-2*overlap_length_mm;
        hole_kernel_width_mm = hole_width_mm+2*rounding_mm;
        hole_length_mm = inner_height_mm-2*overlap_length_mm;
        hole_kernel_length_mm = hole_length_mm+2*rounding_mm;
        translate([0,outer_depth_mm/2,thickness_mm + inner_height_mm/2])
        rotate([0,90,0])
        linear_extrude(outer_width_mm, center=true)
        stadium(d=hole_kernel_width_mm, a=hole_kernel_length_mm-hole_kernel_width_mm, $fn=30);

        // back holes
        for (z = [thickness_mm+inner_height_mm/back_holes_z_count/2 : inner_height_mm/back_holes_z_count : outer_height_mm-inner_height_mm/back_holes_z_count/2],
             x = [inner_width_mm*(1/back_holes_x_count-1)/2 : inner_width_mm/back_holes_x_count : inner_width_mm*(1-1/back_holes_x_count)/2]) {
            $fn = 30;
            translate([x,0,z])
            rotate([-90,0,0])
            cylinder(d=back_holes_diam_mm+2*rounding_mm, h=thickness_mm);
        }

      }
        sphere(r=rounding_mm);
    }
}

hanger();
translate([0,0,outer_height_mm/2])
    mirror([0,1,0]) rails_x2("x");

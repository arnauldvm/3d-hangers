use <modules/fixing.scad>

rounding_mm = 2;
thickness_mm = 5;
overlap_length_mm = 4;

switch_width_mm = 100;
switch_depth_mm = 99;
switch_height_mm = 26;
play_mm = 0.1;

actual_width_mm = switch_width_mm + play_mm;
actual_depth_mm = switch_depth_mm + play_mm;
actual_height_mm = switch_height_mm + play_mm;

module hanger() {
    inner_kernel_width_mm = actual_width_mm - 2*rounding_mm;
    outer_kernel_width_mm = actual_width_mm + 2*thickness_mm - 2*rounding_mm;
    inner_kernel_depth_mm = actual_height_mm - 2*rounding_mm;
    outer_kernel_depth_mm = actual_height_mm + 2*thickness_mm - 2*rounding_mm;
    //inner_kernel_height_mm = actual_depth_mm - rounding_mm;
    outer_kernel_height_mm = actual_depth_mm + thickness_mm - rounding_mm;

    translate([0, 0, rounding_mm])
    minkowski() {
        $fn = 20; // no need for many facets here
        union() {
            linear_extrude([0,0,outer_kernel_height_mm])
            difference() {
                translate([-outer_kernel_width_mm/2,rounding_mm])
                    square([outer_kernel_width_mm, outer_kernel_depth_mm]);
                translate([-inner_kernel_width_mm/2,thickness_mm+rounding_mm])
                    offset(r=2*rounding_mm) square([inner_kernel_width_mm, inner_kernel_depth_mm]);
                translate([-actual_width_mm/2 + overlap_length_mm - rounding_mm, thickness_mm+rounding_mm, 0])
                    square([actual_width_mm - 2*overlap_length_mm + 2*rounding_mm, outer_kernel_depth_mm]);
            }

            lower_overlap_width_mm = thickness_mm + overlap_length_mm - 2*rounding_mm;
            translate([outer_kernel_width_mm/2-lower_overlap_width_mm,rounding_mm,0])
                cube([lower_overlap_width_mm, outer_kernel_depth_mm, thickness_mm-2*rounding_mm]);
            translate([-outer_kernel_width_mm/2,rounding_mm,0])
                cube([lower_overlap_width_mm, outer_kernel_depth_mm, thickness_mm-2*rounding_mm]);

        }
        sphere(r=rounding_mm);
    }
}

hanger();
translate([0,0,(actual_depth_mm + thickness_mm)/2])
    mirror([0,1,0]) rails_x2("x");

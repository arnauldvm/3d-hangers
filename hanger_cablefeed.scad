use <modules/shapes.scad>
include <modules/fixing.inc.scad>
include <modules/hanger.inc.scad>
use <modules/fixing.scad>

max_cable_diam_mm = 5;
fine_thickness_mm = 3;
small_rounding_mm=1.49;
assert(fine_thickness_mm>2*small_rounding_mm, "thickness_mm is too small");

cablefeed_width_mm = beam_width_mm+overlap_width_mm+thickness_mm;
hanger_big_depth_mm = cablefeed_width_mm/2 + fine_thickness_mm/2;
hanger_small_depth_mm = hanger_big_depth_mm - max_cable_diam_mm - 2*small_rounding_mm;
hanger_height_mm = height_mm + 2*overlap_length_mm - 2*small_rounding_mm;
hole_width_mm = beam_width_mm/2-2*small_rounding_mm;

kernel_thickness_mm = thickness_mm - 2*small_rounding_mm;
kernel_fine_thickness_mm = fine_thickness_mm - 2*small_rounding_mm;
kernel_cablefeed_width_mm = cablefeed_width_mm - 2*small_rounding_mm;

minkowski() {
    $fn = 12; // no need for many facets here
    difference() {
        translate([(thickness_mm-overlap_width_mm)/2, small_rounding_mm])
        linear_extrude(hanger_height_mm, center=true)
        union() {
            $fn = 60;
            translate([-kernel_cablefeed_width_mm/2, 0])
            square([kernel_cablefeed_width_mm, kernel_thickness_mm]);

            mirror([1,0,0])
            translate([kernel_cablefeed_width_mm/2-hanger_small_depth_mm, kernel_thickness_mm])
            difference() {
                pie_slice(r=hanger_small_depth_mm, angle=65);
                pie_slice(r=hanger_small_depth_mm-kernel_fine_thickness_mm, angle=65);
            }

            translate([kernel_cablefeed_width_mm/2-hanger_big_depth_mm, kernel_thickness_mm])
            difference() {
                pie_slice(r=hanger_big_depth_mm, angle=135);
                pie_slice(r=hanger_big_depth_mm-kernel_fine_thickness_mm, angle=135);
            }
        }
        rotate([0,90,90])
        linear_extrude(thickness_mm, center=false)
        stadium(d=hole_width_mm, a=hanger_height_mm-2*overlap_length_mm-hole_width_mm, center=true, $fn=30);
    }
    sphere(r=small_rounding_mm);
}

mirror([0,1,0]) rails_x2("x");

use <modules/shapes.scad>
include <modules/fixing.inc.scad>
include <modules/hanger.inc.scad>
use <modules/fixing.scad>

max_cable_diam_mm = 5/2; // we make it smaller, since we can flex the PETG a bit

cablefeed_width_mm = beam_width_mm+overlap_width_mm+thickness_mm;
hanger_big_depth_mm = cablefeed_width_mm/2 + rounding_mm;
hanger_small_depth_mm = hanger_big_depth_mm - max_cable_diam_mm - rounding_mm;
hanger_height_mm = height_mm + 2*overlap_length_mm - 2*rounding_mm;

kernel_thickness_mm = thickness_mm - 2*rounding_mm;
kernel_cablefeed_width_mm = cablefeed_width_mm - 2*rounding_mm;

translate([(thickness_mm-overlap_width_mm)/2, thickness_mm/2])
minkowski() {
    $fn = 12; // no need for many facets here
    linear_extrude(hanger_height_mm, center=true)
    union() {
        $fn = 30;
        translate([-kernel_cablefeed_width_mm/2, 0])
        square([kernel_cablefeed_width_mm, kernel_thickness_mm]);

        mirror([1,0,0])
        translate([kernel_cablefeed_width_mm/2-hanger_small_depth_mm, kernel_thickness_mm])
        difference() {
            pie_slice(r=hanger_small_depth_mm, angle=50);
            pie_slice(r=hanger_small_depth_mm-kernel_thickness_mm, angle=50);
        }

        translate([kernel_cablefeed_width_mm/2-hanger_big_depth_mm, kernel_thickness_mm])
        difference() {
            pie_slice(r=hanger_big_depth_mm, angle=135);
            pie_slice(r=hanger_big_depth_mm-kernel_thickness_mm, angle=135);
        }
    }
    sphere(r=rounding_mm);
}

mirror([0,1,0]) rails_x2("x");

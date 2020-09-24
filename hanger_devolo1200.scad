use <modules/devolo.scad>
use <modules/hanger.scad>

include <modules/fixing.inc.scad>
include <modules/hanger.inc.scad>
include <modules/devolo.inc.scad>

spacing_mm = 5;

big_hole_play_mm = 1; // bigger play than usual

mirror([1,0,0])
difference() {
    union() {
        rail_offset_x_mm = plug_male_dist_mm+plug_male_diam_mm/2+socket_outer_diam_mm/2+spacing_mm+beam_width_mm/2+thickness_mm - devolo_face_length_mm/2;
        hanger(
            hanger_height_mm = devolo_face_width_mm,
            hanger_width_mm = devolo_face_length_mm,
            hanger_depth_mm = devolo_depth_mm,
            overlap_length_mm = 9,
            back_holes_diam_mm = 40,
            back_holes_z_count = 1,
            back_holes_x_count = 2,
            rail_offset_x_mm = rail_offset_x_mm
        );
        translate([rail_offset_x_mm+15, thickness_mm/2, thickness_mm+devolo_face_width_mm/2]) cube([10, thickness_mm, 50], center=true);
    }
    translate([-devolo_face_length_mm/2+plug_male_dist_mm+plug_male_diam_mm/2, thickness_mm/2, devolo_face_width_mm/2+thickness_mm+play_mm])
    rotate([90,0,0]) cylinder(h=thickness_mm, d=socket_outer_diam_mm+2*big_hole_play_mm, center=true);
    #translate([-devolo_face_length_mm/2, devolo_depth_mm+thickness_mm+play_mm, thickness_mm+play_mm])
    rotate([90,0,0]) {
        devolo();
        socket();
    }
}
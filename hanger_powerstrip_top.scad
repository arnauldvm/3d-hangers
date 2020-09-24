include <modules/hanger.inc.scad>
use <modules/hanger.scad>

powerstrip_width_mm = 75.15;
powerstrip_thickness_mm = 41;
powerstrip_small_thickness_mm = 35.7;
hanger_length_mm = 60; // arbitrary
wide_overlap_length_mm = 7;
narrow_overlap_length_mm = 3;
cable_connector_diam_mm = 23.25;

// union() {
    hanger(
        hanger_height_mm = hanger_length_mm,
        hanger_width_mm = powerstrip_width_mm,
        hanger_depth_mm = powerstrip_thickness_mm,
        overlap_length_mm = narrow_overlap_length_mm,
        lower_overlap_length_mm = 0,
        side_overlap_length_mm = 6.5, // free space is 6.7
        back_holes_diam_mm = 10
    );

    color("cyan")
    translate([
        -(powerstrip_width_mm/2+play_mm-play_mm/2)                 -2*rounding_mm       +rounding_mm,
        thickness_mm+powerstrip_small_thickness_mm+play_mm                              +rounding_mm,
        0                                                                               +rounding_mm
        ])
    minkowski() {
        $fn = 12; // no need for many facets here
        cube([
            narrow_overlap_length_mm-rounding_mm                    +2*rounding_mm      -rounding_mm,
            powerstrip_thickness_mm-powerstrip_small_thickness_mm   +thickness_mm       -2*rounding_mm,
            thickness_mm+hanger_length_mm+play_mm/*-rounding_mm*/   +rounding_mm        -2*rounding_mm
            ]);
        sphere(r=rounding_mm);
    }

    color("cyan")
    mirror([1,0,0,])
    translate([
        -(powerstrip_width_mm/2+play_mm-play_mm/2)                 -2*rounding_mm       +rounding_mm,
        thickness_mm+powerstrip_thickness_mm+play_mm                                    +rounding_mm,
        0                                                                               +rounding_mm
        ])
    minkowski() {
        $fn = 12; // no need for many facets here
        cube([
            wide_overlap_length_mm-rounding_mm                      +2*rounding_mm      -rounding_mm,
            thickness_mm                                                                -2*rounding_mm,
            thickness_mm+hanger_length_mm+play_mm/*-rounding_mm*/   +rounding_mm        -2*rounding_mm
            ]);
        sphere(r=rounding_mm);
    }
// }

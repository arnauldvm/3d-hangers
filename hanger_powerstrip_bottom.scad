include <modules/hanger.inc.scad>
use <modules/hanger.scad>

powerstrip_width_mm = 75.15;
powerstrip_thickness_mm = 41;
powerstrip_small_thickness_mm = 35.7;
hanger_length_mm = 60; // arbitrary
overlap_length_mm = 12.5; // free space is 12.9
cable_connector_diam_mm = 23.25;

union() {
    hanger(
        switch_width_mm = hanger_length_mm,
        switch_depth_mm = powerstrip_width_mm,
        switch_height_mm = powerstrip_thickness_mm,
        overlap_length_mm = overlap_length_mm,
        lower_overlap_length_mm = (powerstrip_width_mm-cable_connector_diam_mm)/2, // = 25.95
        side_overlap_length_mm = 6.5, // free space is 6.7
        back_holes_diam_mm = 10
    );
    color("cyan")
    translate([
        -(powerstrip_width_mm/2+play_mm-play_mm/2)                 -2*rounding_mm       +rounding_mm,
        thickness_mm+powerstrip_small_thickness_mm+play_mm                              +rounding_mm,
        thickness_mm                                                                    +0*rounding_mm
        ])
    minkowski() {
        $fn = 12; // no need for many facets here
        cube([
            overlap_length_mm-rounding_mm                           +2*rounding_mm      -rounding_mm,
            powerstrip_thickness_mm-powerstrip_small_thickness_mm   +thickness_mm/2     -rounding_mm,
            hanger_length_mm+play_mm/*-rounding_mm*/                +rounding_mm        -rounding_mm
            ]);
        sphere(r=rounding_mm);
    }
}

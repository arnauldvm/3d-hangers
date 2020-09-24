include <modules/fixing.inc.scad>
include <modules/hanger.inc.scad>
use <modules/hanger.scad>

max_cable_diam_mm = 5;
cablefeed_width_mm = beam_width_mm+overlap_width_mm+thickness_mm;

hanger(
    hanger_height_mm = height_mm,
    hanger_width_mm = cablefeed_width_mm,
    hanger_depth_mm = 20,
    rail_offset_x_mm = -(thickness_mm-overlap_width_mm)/2,
    overlap_length_mm = (cablefeed_width_mm-max_cable_diam_mm)/2,
    lower_overlap_length_mm = 0,
    back_holes_x_count = 1,
    back_holes_diam_mm = 10
);

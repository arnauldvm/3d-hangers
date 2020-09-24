// See fixing.png for guidance

rounding_mm = 2; // r
height_mm = 45;
beam_width_mm = 40; // BW
beam_rounding_mm = 3; // Br
outer_beam_rounding_mm = 8; // OBr
thickness_mm = 10; // T
assert(thickness_mm>2*rounding_mm, "thickness_mm is too small");
overlap_width_mm = 4.1; // OW; 3 was too small for minkowski, 4 was too small too
assert(overlap_width_mm>2*rounding_mm, "overlap_width_mm is too small");
overlap_length_mm = 4; // OL
assert(overlap_length_mm>rounding_mm, "overlap_length_mm is too small");
hole_diam_mm = 6; // HD
hole_pos_mm = 24; // HP
countersink_diam_mm = 14; // CsW
countersink_depth_mm = 4; // CsS
notch_pos_mm = 5;
notch_height_mm = height_mm-10;
notch_entry_width_mm = 3; // EW
notch_entry_depth_mm = 3; // ED
notch_corner_width_mm = 2; // EW'
notch_corner_depth_mm = 2; // ED'

rail_play_mm = 0.3;

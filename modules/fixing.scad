height_mm = 45;
beam_width_mm = 40;
thickness_mm = 10;
overlap_mm = 3;
hole_diam_mm = 6;
hole_pos_mm = 24;

module fixing() {
    difference() {
        linear_extrude(height_mm)
            difference() {
                square([beam_width_mm+thickness_mm+overlap_mm,beam_width_mm+thickness_mm+overlap_mm]);
                translate([thickness_mm, thickness_mm]) square([beam_width_mm,beam_width_mm]);
                translate([thickness_mm+overlap_mm, thickness_mm+overlap_mm]) square([beam_width_mm+1,beam_width_mm+1]);
            }
        translate([thickness_mm+hole_pos_mm, -1, height_mm/2]) rotate([-90,0,0]) cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
        translate([-1, thickness_mm+hole_pos_mm, height_mm/2]) rotate([0,90,0]) cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
    }
}

fixing();

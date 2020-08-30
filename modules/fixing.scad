height_mm = 45;
beam_width_mm = 40;
beam_rounding_mm = 3;
thickness_mm = 10;
overlap_width_mm = 4.1; // 3 was too small for minkowski, 4 was too small too
overlap_length_mm = 4;
hole_diam_mm = 6;
hole_pos_mm = 24;
rounding_mm = 2;

module fixing() {
    difference() {
        minkowski() {
            $fn = 20; // no need for many facets here
            linear_extrude(height_mm)
            union() {
                difference() {
                    square(beam_width_mm+thickness_mm+overlap_width_mm-2*rounding_mm);
                    translate([thickness_mm-2*rounding_mm, thickness_mm-2*rounding_mm]) square(beam_width_mm+2*rounding_mm);
                    translate([thickness_mm+overlap_length_mm-2*rounding_mm, thickness_mm+overlap_length_mm-2*rounding_mm]) square(beam_width_mm+1);
                }
                translate([thickness_mm-2*rounding_mm, thickness_mm-2*rounding_mm]) difference() {
                    square(beam_rounding_mm+rounding_mm);
                    translate([beam_rounding_mm+rounding_mm, beam_rounding_mm+rounding_mm]) circle($fn=20, r=beam_rounding_mm+rounding_mm);
                }
            }
            sphere(r=rounding_mm);
        }
        translate([thickness_mm+hole_pos_mm-rounding_mm, -1-rounding_mm, height_mm/2]) rotate([-90,0,0]) cylinder($fn=60, h=thickness_mm+2*rounding_mm+2, d=hole_diam_mm);
        translate([-1-rounding_mm, thickness_mm+hole_pos_mm-rounding_mm, height_mm/2]) rotate([0,90,0]) cylinder($fn=60, h=thickness_mm+2*rounding_mm+2, d=hole_diam_mm);
    }
}

fixing();

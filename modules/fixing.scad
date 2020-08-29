height_mm = 45;
beam_width_mm = 40;
thickness_mm = 10;
overlap_mm = 4.1; // 3 was too small for minkowski, 4 was too small too
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
                    square([beam_width_mm+thickness_mm+overlap_mm-2*rounding_mm,beam_width_mm+thickness_mm+overlap_mm-2*rounding_mm]);
                    translate([thickness_mm-2*rounding_mm, thickness_mm-2*rounding_mm]) square([beam_width_mm+2*rounding_mm,beam_width_mm+2*rounding_mm]);
                    translate([thickness_mm+overlap_mm-rounding_mm, thickness_mm+overlap_mm-rounding_mm]) square([beam_width_mm+1,beam_width_mm+1]);
                }
                translate([thickness_mm-2*rounding_mm, thickness_mm-2*rounding_mm]) difference() {
                    square(2*rounding_mm);
                    translate([2*rounding_mm, 2*rounding_mm]) circle($fn=20, r=2*rounding_mm);
                }
            }
            sphere(r=rounding_mm);
        }
        translate([thickness_mm+hole_pos_mm-rounding_mm, -1-rounding_mm, height_mm/2]) rotate([-90,0,0]) cylinder($fn=60, h=thickness_mm+2*rounding_mm+2, d=hole_diam_mm);
        translate([-1-rounding_mm, thickness_mm+hole_pos_mm-rounding_mm, height_mm/2]) rotate([0,90,0]) cylinder($fn=60, h=thickness_mm+2*rounding_mm+2, d=hole_diam_mm);
    }
}

fixing();

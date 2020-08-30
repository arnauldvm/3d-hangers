// See fixing.png for guidance

rounding_mm = 2;
height_mm = 45;
beam_width_mm = 40;
beam_rounding_mm = 3;
thickness_mm = 10;
assert(thickness_mm>2*rounding_mm, "thickness_mm is too small");
overlap_width_mm = 4.1; // 3 was too small for minkowski, 4 was too small too
assert(overlap_width_mm>2*rounding_mm, "overlap_width_mm is too small");
overlap_length_mm = 4;
assert(overlap_length_mm>rounding_mm, "overlap_length_mm is too small");
hole_diam_mm = 6;
hole_pos_mm = 24;
countersink_diam_mm = 10;
countersink_depth_mm = 3;

module fixing() {
    // "kernel" measures = measures before rounding (minkowski)
    kernel_height_mm = height_mm-2*rounding_mm;
    kernel_thickness_mm = thickness_mm-2*rounding_mm;
    kernel_beam_rounding_mm = beam_rounding_mm+rounding_mm;

    difference() {
        minkowski() {
            $fn = 20; // no need for many facets here
            linear_extrude(kernel_height_mm)
            union() {
                difference() {
                    square(beam_width_mm+kernel_thickness_mm+overlap_width_mm);
                    translate([kernel_thickness_mm, kernel_thickness_mm])
                        square(beam_width_mm+2*rounding_mm);
                    translate([kernel_thickness_mm+overlap_length_mm, kernel_thickness_mm+overlap_length_mm])
                        square(beam_width_mm+1);
                }
                translate([kernel_thickness_mm, kernel_thickness_mm]) difference() {
                    square(kernel_beam_rounding_mm);
                    translate([kernel_beam_rounding_mm, kernel_beam_rounding_mm])
                        circle($fn=20, r=kernel_beam_rounding_mm);
                }
            }
            sphere(r=rounding_mm);
        }
        translate([kernel_thickness_mm+rounding_mm+hole_pos_mm, -1-rounding_mm, height_mm/2-rounding_mm]) rotate([-90,0,0]) {
            cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
            cylinder($fn=60, h=countersink_depth_mm+1, d=countersink_diam_mm);
        }
        translate([-1-rounding_mm, kernel_thickness_mm+rounding_mm+hole_pos_mm, height_mm/2-rounding_mm]) rotate([0,90,0]) {
            cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
            cylinder($fn=60, h=countersink_depth_mm+1, d=countersink_diam_mm);
        }
    }
}

fixing();

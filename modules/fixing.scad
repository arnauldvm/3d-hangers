// See fixing.png for guidance

include <fixing.inc.scad>

module rail(play_mm=rail_play_mm, height_offset_mm=0) {
    actual_height_mm = notch_height_mm + height_offset_mm - play_mm;
    actual_entry_width_mm = notch_entry_width_mm - 2*play_mm;
    actual_entry_depth_mm = notch_entry_depth_mm + 2*play_mm;
    actual_corner_width_mm = notch_corner_width_mm;
    actual_corner_depth_mm = notch_corner_depth_mm - 2*play_mm;
    entry_overflow_mm = 1;

    translate([0,0,height_mm-actual_height_mm])
    difference() {
        linear_extrude(actual_height_mm)
        union() {
            translate([-actual_entry_width_mm/2, -entry_overflow_mm])
                square([actual_entry_width_mm, actual_entry_depth_mm+entry_overflow_mm]);
            translate([-actual_entry_width_mm/2-actual_corner_width_mm, actual_entry_depth_mm])
                square([actual_entry_width_mm+2*actual_corner_width_mm, actual_corner_depth_mm]);
        }

        // bottom rounding
        d = actual_entry_width_mm+2*actual_corner_width_mm;
        translate([0, -1, d/2])
        rotate([-90,0,0])
        linear_extrude(actual_entry_depth_mm+actual_corner_depth_mm+2)
        difference() {
            translate([-d/2-1,0]) square([d+2, d/2+1]);
            circle(d=d);
        }
    }
}

module rails_x2(along="x", play_mm=rail_play_mm, height_offset_mm=0, center=true) {
    rotation = along=="x"?0:along=="y"?90:undef;
    rotate([0,0,rotation]) translate([center?-thickness_mm-beam_width_mm/2:0,0,center?-height_mm/2:0]) {
        translate([thickness_mm+notch_pos_mm, 0, 0]) rotate([0,0,-2*rotation]) rail(play_mm, height_offset_mm);
        translate([thickness_mm+beam_width_mm-notch_pos_mm, 0, 0]) rotate([0,0,-2*rotation]) rail(play_mm, height_offset_mm);
    }
}

module notch() {
    rail(play_mm=0, height_offset_mm=1);
}

module notches_x2(along="x", center=false) {
    rails_x2(along=along, play_mm=0, height_offset_mm=1, center=center);
}

module fixing(with_notches=true) {
    // "kernel" measures = measures before rounding (minkowski)
    kernel_height_mm = height_mm-2*rounding_mm;
    kernel_thickness_mm = thickness_mm-2*rounding_mm; // kT
    kernel_beam_rounding_mm = beam_rounding_mm+rounding_mm; // kBr
    kernel_outer_beam_rounding_mm = outer_beam_rounding_mm-rounding_mm; // kOBr

    difference() {
        translate([rounding_mm, rounding_mm, rounding_mm])
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
                    difference() {
                        square(kernel_outer_beam_rounding_mm);
                        translate([kernel_outer_beam_rounding_mm, kernel_outer_beam_rounding_mm])
                            circle($fn=20, r=kernel_outer_beam_rounding_mm);
                    }
                }
                translate([kernel_thickness_mm, kernel_thickness_mm]) difference() {
                    square(kernel_beam_rounding_mm);
                    translate([kernel_beam_rounding_mm, kernel_beam_rounding_mm])
                        circle($fn=20, r=kernel_beam_rounding_mm);
                }
            }
            sphere(r=rounding_mm);
        }
        translate([thickness_mm+hole_pos_mm, -1, height_mm/2]) rotate([-90,0,0]) {
            cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
            cylinder($fn=60, h=countersink_depth_mm+1, d=countersink_diam_mm);
        }
        translate([-1, thickness_mm+hole_pos_mm, height_mm/2]) rotate([0,90,0]) {
            cylinder($fn=60, h=thickness_mm+2, d=hole_diam_mm);
            cylinder($fn=60, h=countersink_depth_mm+1, d=countersink_diam_mm);
        }
        if (with_notches) {
            notches_x2("x");
            notches_x2("y");
        }
    }
}

fixing(true);

// Tests

module rails_test() {
    test_width_mm = beam_width_mm+overlap_width_mm+thickness_mm;
    union() {
        $fn = 20;
        translate([-beam_width_mm/2-thickness_mm, -thickness_mm/2, -height_mm/2]) cube([test_width_mm, thickness_mm/2, height_mm]);
        rails_x2("x", center=true);
    }
}

module notches_test() {
    test_width_mm = beam_width_mm+overlap_width_mm+thickness_mm;
    difference() {
        $fn = 20;
        translate([-beam_width_mm/2-thickness_mm, 0, -height_mm/2]) cube([test_width_mm, thickness_mm, height_mm]);
        translate([0, 0, 1]) notches_x2("x", center=true);
    }
}

module all_tests() {
    translate([0, thickness_mm]) notches_test();
    translate([0, -thickness_mm]) rails_test();
}

module visual_test() {
    color("green") notches_test();
    color("red") translate([0,-rail_play_mm,0]) rails_test();
}

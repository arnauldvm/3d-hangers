include <devolo.inc.scad>

function average(a, b) = (a+b)/2;

module devolo() {
    difference() {
        union() {
            // body
            scale_along_x = devolo_inner_length_mm/devolo_face_length_mm;
            scale_along_y = devolo_inner_width_mm/devolo_face_width_mm;
            translate([devolo_face_length_mm/2, devolo_face_width_mm/2])
            linear_extrude(devolo_depth_mm, scale=[scale_along_x, scale_along_y])
            offset(r=devolo_face_rounding_mm) offset(delta=-devolo_face_rounding_mm) square([devolo_face_length_mm, devolo_face_width_mm], center=true);

            // plug male
            translate([plug_male_dist_mm+plug_male_diam_mm/2, devolo_face_width_mm/2, devolo_depth_mm]) cylinder(d=plug_male_diam_mm, h=plug_male_length_mm);
            translate([plug_male_dist_mm+plug_male_diam_mm/2, devolo_face_width_mm/2-plug_male_conn_spacing_mm/2, devolo_depth_mm+plug_male_length_mm]) cylinder(d=plug_male_conn_diam_mm, h=plug_male_conn_length_mm);
            translate([plug_male_dist_mm+plug_male_diam_mm/2, devolo_face_width_mm/2+plug_male_conn_spacing_mm/2, devolo_depth_mm+plug_male_length_mm]) cylinder(d=plug_male_conn_diam_mm, h=plug_male_conn_length_mm);

            // RJ45
            color("black") translate([devolo_inner_length_mm, devolo_face_width_mm/2, devolo_depth_mm-rj45_dist_mm-rj45_height_mm/2]) rotate([90, 0, 90]) cube([rj45_width_mm, rj45_height_mm, 2*rj45_depth_mm], center=true);
        }
    // plug female
    translate([plug_female_dist_mm+plug_female_diam_mm/2, devolo_face_width_mm/2, 0-1]) cylinder(d=plug_female_diam_mm, h=plug_female_depth_mm+1);
    }
}

module socket() {
    translate([plug_male_dist_mm+plug_male_diam_mm/2, devolo_face_width_mm/2, devolo_depth_mm+socket_inner_depth_mm/2])
    difference() {
        cylinder(d=socket_outer_diam_mm, h=socket_inner_depth_mm, center=true);
        cylinder(d=socket_inner_diam_mm, h=socket_inner_depth_mm+1, center=true);
    }
}

devolo();
socket();
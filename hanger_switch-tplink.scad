use <modules/hanger.scad>

switch_width_mm = 100.0; // 100+0.1 = 99.8 measured
switch_depth_mm = 98.6;
switch_height_mm = 25.7; // 26+0.1 = 25.85 measured

hanger(
    hanger_height_mm = switch_width_mm,
    hanger_width_mm = switch_depth_mm,
    hanger_depth_mm = switch_height_mm
);

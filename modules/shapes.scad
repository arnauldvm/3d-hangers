
// See also https://en.wikipedia.org/wiki/Stadium_(geometry)
module stadium(r,d,a,center=true) {
    d = (d==undef)?2*r:d;
    dx = center?0:a-d/2;
    dy = center?0:d/2;
    hull() {
        translate([dx-a/2,dy,0]) circle(d=d);
        translate([dx+a/2,dy,0]) circle(d=d);
    }
}

//stadium(d=10, a=20, $fn=30);
//stadium(d=10, a=20, center=false);

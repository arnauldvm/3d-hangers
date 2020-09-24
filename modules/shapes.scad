
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

module quadrant(r) {
    intersection() {
        circle(r);
        square(r);
    }
}

// quadrant(r=20);

module semicircle(r) {
    intersection() {
        circle(r);
        translate([-r,0]) square([2*r,r]);
    }
}

// semicircle(r=20);

module pie_slice(r, angle) {
    sa = sin(angle);
    ca = cos(angle);
    ta = tan(angle);
    conv = sa>0?2:4;
    if (ca>=0) {
        v = [[0,0],[r,0],[r,r*ta]];
        if (sa>=0) {
            intersection() {
                circle(r);
                polygon(v, 2);
            }
        } else {
            difference() {
                circle(r);
                polygon(v, 2);
            }
        }
    } else {
        v = [[0,0],[r,0],[r,r],[-r,r],[-r,-r*ta]];
        conv = sa>=0?2:4;
        intersection() {
            circle(r);
            polygon(v, conv);
        }
    } 
}

// !pie_slice(10, 60);
// !pie_slice(10, 120);
// !pie_slice(10, -120);
// !pie_slice(10, -60);

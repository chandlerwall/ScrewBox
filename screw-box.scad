module roundedRect(size, r) {

x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull()
{
    // The circles are placed so that the outside bounding box matches the incoming x and y
    translate([(-x/2) + r, (-y/2) + r, 0])
    circle(r=r);

    translate([(x/2) - r, (-y/2) + r, 0])
    circle(r=r);

    translate([(-x/2) + r, (y/2) - r, 0])
    circle(r=r);

    translate([(x/2) - r, (y/2) - r, 0])
    circle(r=r);
}
}

module roundedRectOutline(w, l, r)
{
	difference(){
		roundedRect([w,l,box_h],r);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([w - (perimeter_w),l - (perimeter_w),box_h],r-1);
	}
}

pad = 0.01;
smooth = 64;
$fn = smooth;

layer_height = 0.5;
first_layer_height = 0.3;
nozzle_d = 0.8;
line_w = nozzle_d;
perimeters = 2;
perimeter_w = perimeters * line_w;
bottom_layers = 2;

box_w = 130;
box_l = box_w;
box_h = 15;

small_w = box_w/6;
small_l = box_l/6;

medium_w = box_w/3;
medium_l = small_l;

large_w = box_w/2;
large_l = medium_l;

union(){
	// Main/container box
	difference(){
		roundedRect([box_w - perimeter_w,box_l - perimeter_w,box_h],8);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([box_w - perimeter_w - (2 * perimeter_w),box_l - perimeter_w - (2 * perimeter_w),box_h],7);
	}

	translate([small_w/2,-medium_l,0])
	roundedRectOutline(large_w, large_l, 3);

	// Middle row
	#translate([small_w * 5/2 - 1/2 * perimeter_w,0,0])
	roundedRectOutline(small_w, small_l, 3);

	translate([small_w * 3/2 - 1/4 * perimeter_w,0,0])
	roundedRectOutline(small_w, small_l, 3);

	#translate([0,0,0])
	roundedRectOutline(medium_w, medium_l, 3);

	translate([small_w * -3/2 + 1/4 * perimeter_w,0,0])
	roundedRectOutline(small_w, small_l, 3);

	#translate([small_w * -5/2 + 1/2 * perimeter_w,0,0])
	roundedRectOutline(small_w, small_l, 3);

	// 
	translate([-1/2 * perimeter_w,medium_l - 1/4 * perimeter_w,0])
	roundedRectOutline(medium_w, medium_l, 3);

	#translate([medium_l * 2 - perimeter_w,medium_l - 1/4 * perimeter_w,0])
	roundedRectOutline(medium_w, medium_l, 3);
}
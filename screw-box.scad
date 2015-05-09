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
	difference(){
		roundedRect([box_w - perimeter_w,box_l - perimeter_w,box_h],8);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([box_w - perimeter_w - (2 * perimeter_w),box_l - perimeter_w - (2 * perimeter_w),box_h],7);
	}

	translate([small_w/2 - perimeter_w,-medium_l + perimeter_w - pad,0])
	difference(){
		roundedRect([large_w,large_l,box_h],3);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([large_w - (2 * perimeter_w),large_l - (2 * perimeter_w),box_h],2);
	}

	translate([-perimeter_w + pad,0,0])
	difference(){
		roundedRect([medium_w,medium_l,box_h],3);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([medium_w - (2 * perimeter_w),medium_l - (2 * perimeter_w),box_h],2);
	}

	translate([small_w * 3/2 - perimeter_w + pad,0,0])
	difference(){
		roundedRect([small_w,small_l,box_h],3);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([small_w - (2 * perimeter_w),small_l - (2 * perimeter_w),box_h],2);
	}

	translate([-perimeter_w + pad,medium_l - perimeter_w + pad,0])
	difference(){
		roundedRect([medium_w,medium_l,box_h],3);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([medium_w - (2 * perimeter_w),medium_l - (2 * perimeter_w),box_h],2);
	}

	translate([medium_l * 2 - perimeter_w + pad,medium_l - perimeter_w + pad,0])
	difference(){
		roundedRect([medium_w,medium_l,box_h],3);
		translate([0,0,(bottom_layers * layer_height) + first_layer_height])
		roundedRect([medium_w - (2 * perimeter_w),medium_l - (2 * perimeter_w),box_h],2);
	}
}
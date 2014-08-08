
include <library/functions.scad>;
include <honeycomb/honeycomb.scad>;

//swiss card details:
cardheight=4.5+0.6;
cardwidth=54.5+0.6;
cardlength=82+5;
cardlipwidth=10;
cardlipthickness=0.9;
cardtopthicnkess=0.9;
cardbottomlipwidth=0.9;
cardbottomcoverlength=20;
coverthickness=0.6;



length = 90;
width =cardwidth+cardlipthickness;
thickness = 1.5;
hole = 3;
bodyLength = 88;
bodyWidth = 44;
curvatureOfEdges = 3.5;
curvatureResolution = 20;
screwHoleSize = 4;
screwHeadSize = 6;
sideThickness = 2;
cutoutOffset = 28; //Fingernail offset from centre hole of model
LkeyHoleOffset = 0; //How far from the end of the body the key holes are
cutoutradius=40;
bottomcutoutradius=10;
tabheight=25;
bottomtabheight=20;
middlescrewoffset=11;


//cusomisations
keyhole=1;
card=0;




//  swiss card official measurements:  82 x 54.5 x 4.5 mm


//finger cutouts
module fingertab(height, cradius,sradius){

		hull(){
						cylinder(r=cradius,h=height);
						sphere(r=sradius);


				}

}

//main body without cutouts
module body (length, width, thickness){
//main body
cube ([length, width, thickness]);

}


//mainbody cutouts
module cutouts(screwHoleSzie, width, length, cutoutradius, hole, thickness){

//left screw holes
        //Screw Hole top
		translate([5,width/3,0])
		difference(){
		//cylinder(r1=screwHoleSize/2,r2=
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
			}
		//Screw Hole Middle
		translate([length/2+middlescrewoffset,(width/3+width/middlescrewoffset),0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
	
		//Screw Hole  bottom
		translate([length-5,width/3,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);

      //right screw holes
          //Screw Hole top
		translate([5,width-width/3,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
	
		//Screw Hole Middle
		translate([length/2-middlescrewoffset,width-(width/3+width/middlescrewoffset),0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
	
		//Screw Hole  bottom
		translate([length-5,width-width/3,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
		

		//Captive nut holes left
			//Captive nut Hole top
			translate([5,width/3,0])
			nut(5.5,4);
	
			//Captive nut Hole Middle
			translate([length/2+middlescrewoffset,width/3+width/middlescrewoffset,0])
			nut(5.5,4);
	
			//Captive nut Hole bottom
			translate([length-5,width/3,0])
			nut(5.5,4);

		//Captive nut holes right
			//Captive nut Hole top
			translate([5,width-width/3,0])
			nut(5.5,4);
	
			//Captive nut Hole Middle
			translate([length/2-middlescrewoffset,width-(width/3+width/middlescrewoffset),0])
			nut(5.5,4);
	
			//Captive nut Hole bottom
			translate([length-5,width-width/3,0])
			nut(5.5,4);


			//Left Fingernail opener cutout
			translate([length/2,-cutoutOffset,-tabheight/2])
			fingertab(tabheight,cutoutradius,cutoutradius);
	
			//Right Fingernail opener cutout
			translate([length/2,cutoutOffset+width,-tabheight/2])
			fingertab(tabheight,cutoutradius,cutoutradius);
			
		//	pencil_holder(honeycomb_radius, cell_radius, height, 200);
					
					//keyhole on corner
					if(keyhole == 1){
					translate([5,5,0])
						difference(){
								cylinder(r=hole, h=thickness, $fn=5 );
								cylinder(r=0, h=thickness, $fn=5);
						  			}

								}

				translate([length/2,width/2-cutoutradius/1.8,-5])
					fingertab(bottomtabheight,cutoutradius/3,bottomcutoutradius);

				translate([length/2,width/2+cutoutradius/1.8,-5])
					fingertab(bottomtabheight,cutoutradius/3,bottomcutoutradius);

				

				/****************  swiss card cutouts *****************/

		//Fingernail opener cutout bottom (swisscard)
					if(card==1){
					translate([length+5,width/2,-bottomtabheight/2])
					fingertab(bottomtabheight,bottomcutoutradius,bottomcutoutradius);
					
						}
		
		
		// cutouts end
	}



module swisscard(cardlength, cardlipthickness,cardheigh,coverthickness,cardbottomlipwidth, width, length, cutoutradius, hole, thickness){

	
							//swiss card holder
	if(card==1){
	
	translate([0,0,-coverthickness-cardheight]){
		
		 union(){
			//left lip
			translate([length-cardlength,0,0])
			cube([cardlength, cardlipthickness, cardheight+coverthickness]);
			
			
			//right lip
			translate([length-cardlength,width-cardlipthickness,0])
			cube([cardlength, cardlipthickness, cardheight+coverthickness]);
			
			
			//bottom lip
			translate([length-cardbottomlipwidth,0,0])
			cube([cardbottomlipwidth,width,cardheight+coverthickness]);
			
			
			//bottom cover
			translate([length-cardbottomcoverlength,0,0])
			cube([cardbottomcoverlength,width,coverthickness]);
			
			
			//top cover
			translate([length-cardlength,0,0])
			cube([cardbottomcoverlength+60,width,coverthickness]);
			
		   //union end
		  }
	
	// card translation end
	}
	
	// card customisation end
	}



//swisscard end
}


module cardplusbody(cardlength, cardlipthickness,cardheigh,coverthickness,cardbottomlipwidth, width, length, cutoutradius, hole, thickness){
	union(){
	body (length, width, thickness);
	swisscard(cardlength, cardlipthickness,cardheigh,coverthickness,cardbottomlipwidth, width, length, cutoutradius, hole, thickness);
	}
}


/************************************   Program begin *****************************/

translate(0,0,0){
difference(){

//main body
cardplusbody(cardlength, cardlipthickness,cardheigh,coverthickness,cardbottomlipwidth, width, length, cutoutradius, hole, thickness);

//Cut outs
	union()
	{
	  
cutouts(screwHoleSzie, width, length, cutoutradius, hole, thickness);
	
			//end of union
		}

		//end of difference
		}
		
	//end of final translate
}


//cell(20,10,0);





module hexagon(radius){
	circle(r=radius,$fn=6);
}

module cell(radius, height, floor_thickness){
	difference(){
		linear_extrude(height=height){hexagon(radius*1.2);} // base
		translate([0,0,floor_thickness]) linear_extrude(height=height){hexagon(radius*1.1);} // hole
		}
}



$fn=30;

module structor(dim)
{
hole_rad = 1.55;
base_len = 5.0;
move=base_len/2;
angle_round_rad = 0.1;

c_c = base_len/2 - sin(45) * hole_rad;
cc= sin(45) * hole_rad;

tooth_matrix = [[-1,0],[-1,1],[0,1],[0,2]];

x=dim[0];
y=dim[1];

left=[
for (ty=[0:y-1])
    for (tp=[0:len(tooth_matrix)-1])
        [tooth_matrix[tp][0],2*ty+tooth_matrix[tp][1]] 
 ];
top =[
    for (tx=[0:x-1])
    for (tp=[0:len(tooth_matrix)-1])
        [2*tx+tooth_matrix[tp][1],2*y-1-tooth_matrix[tp][0]] 
 ];   
right = [
    for (ty=[0:y-1])
    for (tp=[0:len(tooth_matrix)-1])
        [2*x-1-tooth_matrix[tp][0],2*y-1-2*ty-tooth_matrix[tp][1]] 
 ];
bottom = [
    for (tx=[0:x-1])
    for (tp=[0:len(tooth_matrix)-1])
        [2*x-1 - 2*tx-tooth_matrix[tp][1],tooth_matrix[tp][0]] 
 ];   
lp=[left[0]];
    
myFig = base_len * concat(left,top,right,bottom,lp);
    
center_coor =[-x*base_len/2,-y*base_len/2];

linear_extrude(base_len)
    translate([base_len,base_len])
    difference()
    {
        polygon(myFig);
        union()
        {
            for (sQ_x=[0:x-1])
            {
            for (sQ_y = [0:y-1] )
            {
            translate([(2*sQ_x)*base_len-cc, (2*sQ_y)*base_len-cc])
                circle(r=hole_rad);
                
            translate([(2*sQ_x+1)*base_len+cc, (2*sQ_y)*base_len-cc])
                circle(r=hole_rad);         

            translate([(2*sQ_x+1)*base_len+cc, (2*sQ_y+1)*base_len+cc])
                circle(r=hole_rad);
                
            translate([(2*sQ_x)*base_len-cc, (2*sQ_y+1)*base_len+cc])
                circle(r=hole_rad);
            }
        }
             for (sQ_x=[0:x-2])
            {
            for (sQ_y = [0:y-2] )
            {
            translate([base_len*(2*sQ_x+1), base_len*(2*sQ_y+1)])
                square(base_len);
            }
            }
    }
    }        
}

structor([12,12]);


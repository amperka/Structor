$fn=16;
//$fn=8;

module structor(dim, center)
{
//Dimensions
    hole_rad = 1.55;
    base_len = 5.0;

//construct
    x=dim[0];
    y=dim[1];

    hole_to_square= sin(45) * hole_rad;

    tooth_matrix = [[-1,0],[-1,1],[0,1],[0,2]];
    
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

    translate(center ? [-base_len*(x-0.5), -base_len*(y-0.5), -base_len/2] : [base_len,base_len])

        linear_extrude(base_len)
            difference()
            {
                polygon(myFig);
        
                union()
                {
                
                    for (sQ_x=[0:x-1])
                    {
                        for (sQ_y = [0:y-1] )
                        {
                            translate([(2*sQ_x)*base_len-hole_to_square, (2*sQ_y)*base_len-hole_to_square])
                                circle(r=hole_rad);
                
                            translate([(2*sQ_x+1)*base_len+hole_to_square, (2*sQ_y)*base_len-hole_to_square])
                                circle(r=hole_rad);         

                            translate([(2*sQ_x+1)*base_len+hole_to_square, (2*sQ_y+1)*base_len+hole_to_square])
                                circle(r=hole_rad);
                
                            translate([(2*sQ_x)*base_len-hole_to_square, (2*sQ_y+1)*base_len+hole_to_square])
                                circle(r=hole_rad);
                        }
                    }
                if ((x>1)&&(y>1))
                {
                    for (sQ_x=[0:x-2])
                    {
                        for (sQ_y = [0:y-2] )
                        {
                            translate([base_len*(2*sQ_x+1), base_len*(2*sQ_y+1)])
                                square(base_len);
                        }
                    }
                } else 
                {
                    if (x==1)
                        for (sQ_y = [0:y-1] )
                        {
                            translate([0.5*base_len, base_len*(2*sQ_y+0.5)])
                                circle(r=hole_rad); 
                        }
                    if (y==1)
                        for (sQ_x = [0:x-1] )
                        {
                            translate([ 
                base_len*(2*sQ_x+0.5),0.5*base_len])
                                circle(r=hole_rad); 
                        }
        
            
                }
            }        
        }
}

structor([2,2], center=true);


`timescale 1ns/1ps
module FA(a,b,c,sm,cy);  //Area:7
input a,b,c;
output cy,sm;
wire x,y,z;
xor #0.2 x1(x,a,b);
xor #0.2 x2(sm,x,c);
and #0.1 a1(y,a,b);
and #0.1 a2(z,x,c);
or #0.1 o1(cy,y,z);
endmodule

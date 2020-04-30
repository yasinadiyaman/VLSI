`timescale 1ns/1ps
module product(output pp, input yprev, y, single, double, neg);//Area:5

wire [2:0] k;

and #0.1 and0(k[0],y,single);
and #0.1 and1(k[1],yprev,double);
or #0.1 or1(k[2],k[1],k[0]);

xor #0.2 xor1(pp, neg, k[2]);

endmodule



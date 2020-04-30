`timescale 1ns/1ps
module HA(a,b,s,c);//Area:3
input a,b;
output c,s;
xor #0.2 x1(s,a,b);
and #0.1 a1(c,a,b);
endmodule
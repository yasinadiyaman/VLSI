module boothwallace(x,y,p); //Area:45+765+37+65+93+121+149+177+202+527=2181
input [15:0] x,y;
output [31:0] p;

wire [31:0] w0 [8:0];
wire [31:0] w1 [8:0];
wire [31:0] w2 [7:0];
wire [31:0] w3 [6:0];
wire [31:0] w4 [5:0];
wire [31:0] w5 [4:0];
wire [31:0] w6 [3:0];
wire [31:0] w7 [2:0];
wire [31:0] w8 [1:0];

wire[8:0] single;
wire[8:0] double;
wire[8:0] neg;

wire [16:0] pp0;
wire [16:0] pp1;
wire [16:0] pp2;
wire [16:0] pp3;
wire [16:0] pp4;
wire [16:0] pp5;
wire [16:0] pp6;
wire [16:0] pp7;
wire [16:0] pp8;

//Code generation for Booth algorithm  //Area:45
partialcodes partialcodes1(single, double, neg, x);

//Partial product generation with Booth algorithm   //Area:765
partial partial0(pp0, y, single[0], double[0], neg[0]);
partial partial1(pp1, y, single[1], double[1], neg[1]);
partial partial2(pp2, y, single[2], double[2], neg[2]);
partial partial3(pp3, y, single[3], double[3], neg[3]);
partial partial4(pp4, y, single[4], double[4], neg[4]);
partial partial5(pp5, y, single[5], double[5], neg[5]);
partial partial6(pp6, y, single[6], double[6], neg[6]);
partial partial7(pp7, y, single[7], double[7], neg[7]);
partial partial8(pp8, y, single[8], double[8], neg[8]);

//Construct the Wallace tree with sign bits

assign w0[0][16:0] = pp0;
assign w0[0][17] = neg[0];
assign w0[0][18] = neg[0];
assign w0[0][19] = ~neg[0];
assign w0[1][0] = neg[0];


assign w0[1][18:2] = pp1;
assign w0[1][19] = ~neg[1];
assign w0[1][20] = 1'b1 ;
assign w0[2][2] = neg[1];

assign w0[2][20:4] = pp2;
assign w0[2][21] = ~neg[2];
assign w0[2][22] = 1'b1 ;
assign w0[3][4] = neg[2];

assign w0[3][22:6] = pp3;
assign w0[3][23] = ~neg[3];
assign w0[3][24] = 1'b1 ;
assign w0[4][6] = neg[3];

assign w0[4][24:8] = pp4;
assign w0[4][25] = ~neg[4];
assign w0[4][26] = 1'b1 ;
assign w0[5][8] = neg[4];


assign w0[5][26:10] = pp5;
assign w0[5][27] = ~neg[5];
assign w0[5][28] = 1'b1 ;
assign w0[6][10] = neg[5];


assign w0[6][28:12] = pp6;
assign w0[6][29] = ~neg[6];
assign w0[6][30] = 1'b1 ;
assign w0[7][12] = neg[6];


assign w0[7][30:14] = pp7;
assign w0[7][31] = ~neg[7];
assign w0[8][14] = neg[7];

assign w0[8][31:16] = pp8[15:0];



//Stage 1: Constructing the triangular shaped Wallace tree

//assign w1[8:0][19:0] = w0[8:0][19:0] ;
genvar gi;
for (gi=0; gi<9; gi=gi+1) begin : genbit1
	assign w1[gi][19:0] = w0[gi][19:0] ;
end

//assign w1[7:0][20] = w0[8:1][20] ;
for (gi=0; gi<8; gi=gi+1) begin : genbit2
	assign w1[gi][20] = w0[gi+1][20] ;
end

//assign w1[6:0][22:21] = w0[8:2][22:21] ;
for (gi=0; gi<7; gi=gi+1) begin : genbit3
	assign w1[gi][22:21] = w0[gi+2][22:21] ;
end

//assign w1[5:0][24:23] = w0[8:3][24:23] ;
for (gi=0; gi<6; gi=gi+1) begin : genbit4
	assign w1[gi][24:23] = w0[gi+3][24:23] ;
end

//assign w1[4:0][26:25] = w0[8:4][26:25] ;
for (gi=0; gi<5; gi=gi+1) begin : genbit5
	assign w1[gi][26:25] = w0[gi+4][26:25] ;
end

//assign w1[3:0][28:27] = w0[8:5][28:27] ;
for (gi=0; gi<4; gi=gi+1) begin : genbit6
	assign w1[gi][28:27] = w0[gi+5][28:27] ;
end

//assign w1[2:0][30:29] = w0[8:6][30:29] ;
for (gi=0; gi<3; gi=gi+1) begin : genbit7
	assign w1[gi][30:29] = w0[gi+6][30:29] ;
end

//assign w1[1:0][31] = w0[8:7][31] ;
for (gi=0; gi<2; gi=gi+1) begin : genbit8
	assign w1[gi][31] = w0[gi+7][31] ;
end


//Stage 2        Area:37

HA HA01(w1[7][14],w1[8][14],w2[7][14],w2[7][15]);
HA HA02(w1[7][15],w1[6][15],w2[6][15],w2[7][16]);

FA FA01(w1[6][16],w1[7][16],w1[8][16],w2[6][16],w2[7][17]);
FA FA02(w1[6][17],w1[7][17],w1[8][17],w2[6][17],w2[7][18]);
FA FA03(w1[6][18],w1[7][18],w1[8][18],w2[6][18],w2[7][19]);
FA FA04(w1[6][19],w1[7][19],w1[8][19],w2[6][19],w2[7][20]);

HA HA03(w1[6][20],w1[7][20],w2[6][20],w2[7][21]);

//assign w2[5:0] = w1[5:0] ;
for (gi=0; gi<6; gi=gi+1) begin : equalize1
	assign w2[gi] = w1[gi] ;
end
assign w2[6][22:21] = w1[6][22:21] ;
assign w2[6][14:10] = w1[6][14:10] ;
assign w2[7][12] = w1[7][12] ;

//Stage 3       Area:65

HA HA04(w2[7][12],w2[6][12],w3[6][12],w3[6][13]);
HA HA05(w2[5][13],w2[6][13],w3[5][13],w3[6][14]);

for (gi=14; gi<22; gi=gi+1) begin : fagen2
	FA FAarr2(w2[5][gi],w2[6][gi],w2[7][gi],w3[5][gi],w3[6][gi+1]);
end

HA HA06(w2[5][22],w2[6][22],w3[5][22],w3[6][23]);

//assign w3[4:0] = w2[4:0] ;
for (gi=0; gi<5; gi=gi+1) begin : equalize2
	assign w3[gi] = w2[gi] ;
end
assign w3[5][24:23] =  w2[5][24:23] ;
assign w3[5][12:8] =  w2[5][12:8] ;
assign w3[6][10] =  w2[6][10] ;


//Stage 4       Area:93
 
HA HA07(w3[5][10],w3[6][10],w4[5][10],w4[5][11]);
HA HA08(w3[4][11],w3[5][11],w4[4][11],w4[5][12]);

for (gi=12; gi<24; gi=gi+1) begin : fagen3
	FA FAarr3(w3[4][gi],w3[5][gi],w3[6][gi],w4[4][gi],w4[5][gi+1]);
end

HA HA09(w3[4][24],w3[5][24],w4[4][24],w4[5][25]);

//assign w4[3:0] = w3[3:0] ;
for (gi=0; gi<4; gi=gi+1) begin : equalize3
	assign w4[gi] = w3[gi] ;
end
assign w4[4][26:25] =  w3[4][26:25] ;
assign w4[4][10:6] =  w3[4][10:6] ;
assign w4[5][8] =  w3[5][8] ;


//Stage 5       Area:121

HA HA10(w4[4][8],w4[5][8],w5[4][8],w5[4][9]);
HA HA11(w4[3][9],w4[4][9],w5[3][9],w5[4][10]);

for (gi=10; gi<26; gi=gi+1) begin : fagen4
	FA FAarr4(w4[3][gi],w4[4][gi],w4[5][gi],w5[3][gi],w5[4][gi+1]);
end

HA HA012(w4[3][26],w4[4][26],w5[3][26],w5[4][27]);

//assign w5[2:0] = w4[2:0] ;
for (gi=0; gi<3; gi=gi+1) begin : equalize4
	assign w5[gi] = w4[gi] ;
end
assign w5[3][28:27] =  w4[3][28:27] ;
assign w5[3][8:4] =  w4[3][8:4] ;
assign w5[4][6] =  w4[4][6] ;


//Stage 6       Area:149

HA HA13(w5[3][6],w5[4][6],w6[3][6],w6[3][7]);
HA HA14(w5[2][7],w5[3][7],w6[2][7],w6[3][8]);

for (gi=8; gi<28; gi=gi+1) begin : fagen5
	FA FAarr5(w5[2][gi],w5[3][gi],w5[4][gi],w6[2][gi],w6[3][gi+1]);
end

HA HA15(w5[2][28],w5[3][28],w6[2][28],w6[3][29]);

//assign w6[1:0] = w5[1:0] ;
for (gi=0; gi<2; gi=gi+1) begin : equalize5
	assign w6[gi] = w5[gi] ;
end
assign w6[2][30:29] =  w5[2][30:29] ;
assign w6[2][6:2] =  w5[2][6:2] ;
assign w6[3][4] =  w5[3][4];


//Stage 7       Area:177

HA HA16(w6[2][4],w6[3][4],w7[2][4],w7[2][5]);
HA HA17(w6[1][5],w6[2][5],w7[1][5],w7[2][6]);

for (gi=6; gi<30; gi=gi+1) begin : fagen6
	FA FAarr6(w6[1][gi],w6[2][gi],w6[3][gi],w7[1][gi],w7[2][gi+1]);
end

HA HA18(w6[1][30],w6[2][30],w7[1][30],w7[2][31]);

assign w7[0] = w6[0] ;
assign w7[1][31] =  w6[1][31] ;
assign w7[1][4:0] =  w6[1][4:0] ;
assign w7[2][2] =  w6[2][2] ;

//Stage 8       Area:202

HA HA20(w7[1][2],w7[2][2],w8[1][2],w8[1][3]);
HA HA19(w7[0][3],w7[1][3],w8[0][3],w8[1][4]);

for (gi=4; gi<32; gi=gi+1) begin : fagen7
	FA FAarr7(w7[0][gi],w7[1][gi],w7[2][gi],w8[0][gi],w8[1][gi+1]);
end

assign w8[1][0] = w7[1][0] ;
assign w8[0][2:0] =  w7[0][2:0] ;
assign w8[1][1]=1'b0;

//wire al;
//assign {al,p} = w8[0] + w8[1];
wire cout;
KoggeStone32 kk(w8[0], w8[1], 1'b0, p, cout); //Area:527

endmodule

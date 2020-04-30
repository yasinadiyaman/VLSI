module KoggeStone32 (A, B, Cin, S, Cout); //Area: 96+64+303+64=527
    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output Cout;

    wire [31:0]  r1p, r1g; 
    wire [31:1]       r2g; 
    wire [31:2]  r2p, r3g; 
    wire [31:4]  r3p, r4g; 
    wire [31:8]  r4p, r5g;
    wire [31:16] r5p, r6g;  
    wire [31:0] lastg; 
    
    pg32 pg32n1(A, B, r1p, r1g); //Area:96
    assign lastg[0]=r1g[0];


//Black Cell Area=(31+29+25+16)*3=303
//Gray Cell Area=32*2=64
    genvar gi;
    for(gi=31;gi>1;gi=gi-1) begin : blacksr1 
	black blacks1({r1p[gi],r1g[gi]},{r1p[gi-1],r1g[gi-1]},{r2p[gi],r2g[gi]});
    end
    gray g1({r1p[1],r1g[1]}, lastg[0], r2g[1]);
    assign lastg[1]=r2g[1];

    genvar gj;
    for(gj=31;gj>3;gj=gj-1) begin : blacksr2 
	black blacks2({r2p[gj],r2g[gj]},{r2p[gj-2],r2g[gj-2]},{r3p[gj],r3g[gj]});
    end
    gray g21({r2p[2],r2g[2]}, lastg[0], lastg[2]);
    gray g22({r2p[3],r2g[3]}, lastg[1], lastg[3]);

    genvar gk;
    for(gk=31;gk>7;gk=gk-1) begin : blacksr3 
	black blacks3({r3p[gk],r3g[gk]},{r3p[gk-4],r3g[gk-4]},{r4p[gk],r4g[gk]});
    end

    genvar tk;
    for(tk=7;tk>3;tk=tk-1) begin : graysr3 
	gray grays3({r3p[tk],r3g[tk]}, lastg[tk-4], lastg[tk]);
    end

    genvar gk2;
    for(gk2=31;gk2>15;gk2=gk2-1) begin : blacksr4 
	black blacks4({r4p[gk2],r4g[gk2]},{r4p[gk2-8],r4g[gk2-8]},{r5p[gk2],r5g[gk2]});
    end

    genvar tk2;
    for(tk2=15;tk2>7;tk2=tk2-1) begin : graysr4 
	gray grays4({r4p[tk2],r4g[tk2]}, lastg[tk2-8], lastg[tk2]);
    end

    genvar tk3;
    for(tk3=31;tk3>15;tk3=tk3-1) begin : graysr5 
	gray grays5({r5p[tk3],r5g[tk3]}, lastg[tk3-16], lastg[tk3]);
    end

    xor32 x321({lastg[30:0],1'b0}, r1p, S); //Area: 64
    assign Cout=lastg[31];

endmodule

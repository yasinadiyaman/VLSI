module partialcodes(output [8:0] single, double, neg, input [15:0] x); //Area:45

code codefirst ( single[0], double[0], neg[0], x[1], x[0], 1'b0 );

genvar gi;
for (gi=1; gi<8; gi=gi+1) begin : genbit
	code codeall ( single[gi], double[gi], neg[gi], x[2*gi+1], x[2*gi], x[2*gi-1] );
end

code codelast ( single[8], double[8], neg[8],  1'b0,  1'b0, x[15] );

endmodule

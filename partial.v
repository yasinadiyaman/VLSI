module partial(output [16:0] prod, input[15:0] y, input single, double, neg);//Area:85

product pfirst(prod[0], 1'b0, y[0], single, double, neg);

genvar gi;
for (gi=1; gi<16; gi=gi+1) begin : genbit

 product pall(prod[gi], y[gi-1], y[gi], single, double, neg);

end

product plast(prod[16], y[15], 1'b0, single, double, neg);

endmodule



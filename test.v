`timescale 1ns/1ps

module test();

  reg [15:0] A, B;
  wire [31:0] P;
  reg [31:0] ans;
  reg [15:0] testarray[7:0];
  integer i, j;

  boothwallace b32(A, B, P); 
 
  wire control;

  assign control=(P !== ans) ? 1 : 0;

  initial
  begin
    testarray[0]=16'h0001;
    testarray[1]=16'h0000;
    testarray[2]=16'hffff;
    testarray[3]=16'h00ff;
    testarray[4]=16'h7800;
    testarray[5]=16'h8c1b;
    testarray[6]=16'h92a3;
    testarray[7]=16'h7da2;

    for (i = 0; i < 8; i = i + 1) begin
      for (j = 0; j < 8; j = j + 1) begin
        A = testarray[i];
        B = testarray[j];
        ans = A*B;

        #20;

      end
    end

    $finish;
  end

endmodule

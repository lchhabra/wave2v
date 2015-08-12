  `timescale 1ps/1ps
  `include "my_defines.vh"
  module tb();
  parameter N = 4;
  parameter DATAW = 128;
  reg clk;
  reg rst_n;
  reg mysig;
  reg [127:0] mybus1 ;
  reg [3:0] mybus2 ;



  wire myout [DATAW-1:0];

   my_dut my_dut_inst #(.DATAW(DATAW), .N(N))
         (.clk, .rst_n, .sig (mysig),
	  .bus1(mybus1), .bus2 (mybus2),
	  .out(myout[DATAW-1:0]));

  initial begin
    $timeformat(-9, 0, "", 10);
    $vcdplusfile("verilog.vpd");
    $vcdpluson;
    $vcdplusmemon();
  end
  // Can contain any arbitrary verilog code

   initial begin
      mysig = 1'h0;
     #20000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h1;
     #1000 mysig = 1'h1;
     #1000 mysig = 1'h1;
     #1000 mysig = 1'h1;
     #1000 mysig = 1'h0;
     #1000 mysig = 1'h0;
   end
   initial begin
      mybus2 = 4'h0;
     #20000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h0;
     #1000 mybus2 = 4'h3;
     #1000 mybus2 = 4'h3;
     #1000 mybus2 = 4'h3;
     #1000 mybus2 = 4'h3;
     #1000 mybus2 = 4'hf;
     #1000 mybus2 = 4'hf;
     #1000 mybus2 = 4'hf;
     #1000 mybus2 = 4'hf;
   end
   initial begin
      clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
     #1000 clk = 1'h0;
     #1000 clk = 1'h1;
     #1000 clk = 1'h1;
     #1000 clk = 1'h0;
   end
   initial begin
      rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h0;
     #1000 rst_n = 1'h1;
     #1000 rst_n = 1'h1;
   end
   initial begin
      mybus1 = 128'h0;
     #20000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h19343ddf8dfeffab00000000aa55ffaa;
     #1000 mybus1 = 128'h19343ddf8dfeffab00000000aa55ffaa;
     #1000 mybus1 = 128'h19343ddf8dfeffab00000000aa55ffaa;
     #1000 mybus1 = 128'h19343ddf8dfeffab00000000aa55ffaa;
     #1000 mybus1 = 128'h11d80412e4c8bb7e4f60b3ba69e224f;
     #1000 mybus1 = 128'h11d80412e4c8bb7e4f60b3ba69e224f;
     #1000 mybus1 = 128'h11d80412e4c8bb7e4f60b3ba69e224f;
     #1000 mybus1 = 128'h11d80412e4c8bb7e4f60b3ba69e224f;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
     #1000 mybus1 = 128'h0;
   end
   initial #120000 $finish;
  endmodule

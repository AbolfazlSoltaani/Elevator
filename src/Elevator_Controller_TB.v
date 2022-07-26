`timescale 1ns / 1ns
`include "Elevator_Controller.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator_Controller_TB;

reg [4:0] fb;
reg [4:0] sb;
reg [4:0] buttons;
reg clk;

Elevator_Controller uut(fb, sb, buttons, clk, reset);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("Elevator.vcd");
    $dumpvars(0, Elevator_Controller_TB);

    clk = 0;

    #10;
    clk = 1;
    reset = 0;
    buttons = 6;

    #10;
    clk = 0;
    #10;
    clk = 1;
    #10;
end

endmodule

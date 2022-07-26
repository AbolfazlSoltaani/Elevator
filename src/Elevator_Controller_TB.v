`timescale 1ns / 1ns
`include "Elevator_Controller.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator_Controller_TB;

reg [4:0] fb;
reg fin;
wire fout, fup, fdown;
reg [4:0] sb;
reg sin;
wire sout, sup, sdown;

wire [2:0] ffloor;
wire [2:0] sfloor;

reg [4:0] buttons;
reg clk;
reg [4:0] req_floor;
reg reset;

Elevator_Controller uut(fb, fin, fout, ffloor, fup, fdown, 
                        sb, sin, sout, sfloor, sup, sdown, 
                        buttons, clk, reset);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("Elevator.vcd");
    $dumpvars(0, Elevator_Controller_TB);
    fb = 5'b00000;
    sb = 5'b00000;
    buttons = 5'b00000;

    reset = 1;
    #10;
    reset = 0;
    buttons = 5'b10000;
    #10;
    buttons = 5'b00000;
    #100;
    fb = 5'b00100;
    #10;
    fb = 5'b00000;
    #100;
    buttons = 5'b10001;
    #10;
    buttons = 5'b00000;
    
end
endmodule

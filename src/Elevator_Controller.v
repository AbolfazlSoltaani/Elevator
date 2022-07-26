`timescale 1ns / 1ns
`include "Elevator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator_Controller(input [4:0] fb, input [4:0] sb, input [4:0] out_buttons, input clk, input reset);
    
integer cnt;
wire [2:0] ff, sf;
reg [4:0] first_buttons, second_buttons;

Elevator e1 (.buttons(first_buttons), 
            .clk(clk),
            .reset(reset),
            .current_floor(ff));

Elevator e2 (.buttons(second_buttons), 
            .clk(clk),
            .reset(reset),
            .current_floor(sf));

initial begin
    cnt = 0;
    first_buttons = 0;
    second_buttons = 0;
end

always @(out_buttons) begin
    if (cnt == 0) 
        first_buttons = first_buttons | out_buttons;
    else
        second_buttons = second_buttons | out_buttons;
end

always @(fb or sb) begin
    first_buttons = first_buttons | fb;
    second_buttons = second_buttons | sb;
end

endmodule

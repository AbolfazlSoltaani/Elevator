`timescale 1ns / 1ns
`include "Elevator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator_Controller(input [4:0] fb, input [4:0] sb, input [4:0] out_buttons, input clk, input reset);
    
reg cnt;
wire [2:0] ff, sf;
reg [4:0] first_buttons, second_buttons;

Elevator e1 (
            .buttons(first_buttons),
            .clk(clk),
            .reset(reset),
            .current_floor(ff)
            );

Elevator e2 (
            .buttons(second_buttons), 
            .clk(clk),
            .reset(reset),
            .current_floor(sf));

initial begin
    first_buttons = 5'b00000;
    second_buttons = 5'b00000;
    cnt = 0;
end

always @(posedge reset) begin
    first_buttons = 5'b00000;
    second_buttons = 5'b00000;
end

always @(posedge clk) begin
    first_buttons = fb;
    second_buttons = sb;
    if (out_buttons != 0) begin
        if (cnt == 0)
            first_buttons = fb | out_buttons;
        else
            second_buttons = sb | out_buttons;
        cnt = cnt ^ 1;
    end
end

endmodule

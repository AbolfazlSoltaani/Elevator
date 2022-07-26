`timescale 1ns / 1ns
`include "Elevator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator_Controller(fb, fin, fout, ffloor, fgoing_up, fgoing_down, 
                            sb, sin, sout, sfloor, sgoing_up, sgoing_down, 
                            out_buttons, clk, reset);

// First Elevators Buttons
input [4:0] fb;
input fin;
input fout;
output reg [2:0] ffloor;
output fgoing_up;
output fgoing_down;

// Second Elevators Buttons
input [4:0] sb;
input sin;
input sout;
output reg [2:0] sfloor;
output sgoing_up;
output sgoing_down;

// Outer Buttons
input [4:0] out_buttons;

input clk;
input reset;

reg cnt;
wire [2:0] ff, sf;
reg [4:0] first_buttons, second_buttons;
integer i;

Elevator e1 (
            .buttons(first_buttons),
            .come_in(fin),
            .go_out(fout),
            .clk(clk),
            .reset(reset),
            .current_floor(ff),
            .going_up(fgoing_up),
            .going_down(fgoing_down)
            );

Elevator e2 (
            .buttons(second_buttons),
            .come_in(sin),
            .go_out(sout),
            .clk(clk),
            .reset(reset),
            .current_floor(sf),
            .going_up(sgoing_up),
            .going_down(sgoing_down)
            );

initial begin
    first_buttons = 5'b00000;
    second_buttons = 5'b00000;
    cnt = 0;
end

function [3:0] distance;
    input [2:0] elevator_floor;
    input going_up;
    input going_down;
    input [2:0] dest_floor;
    
    begin
        if (going_up) begin
            if (elevator_floor < dest_floor)
                distance = dest_floor - elevator_floor;
            else
                distance = 10 - elevator_floor - dest_floor;
        end
        else if (going_down) begin
            if (elevator_floor < dest_floor)
                distance = 10 - elevator_floor - dest_floor;
            else
                distance = elevator_floor - dest_floor;
        end
        else begin
            if (elevator_floor < dest_floor)
                distance = dest_floor - elevator_floor;
            else
                distance = elevator_floor - dest_floor;
        end
    end

endfunction

always @(posedge clk) begin
    first_buttons = fb;
    second_buttons = sb;
    for (i = 1; i <= 5; i++) begin
        if (out_buttons[i - 1]) begin
            if (distance(ff, fgoing_up, fgoing_down, i) <= distance(sf, sgoing_up, sgoing_up, i))
                first_buttons[i - 1] = 1;
            else
                second_buttons[i - 1] = 1;
        end
    end
end

endmodule

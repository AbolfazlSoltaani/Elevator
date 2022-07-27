`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////

module Elevator(buttons, come_in, go_out, clk, reset, current_floor, going_up, going_down, busy, persons);

parameter OPEN = 1;
parameter CLOSED = 0;

input [4:0] buttons;
input come_in;
input go_out;
input clk;
input reset;

output reg [2:0] current_floor;
output reg going_up;
output reg going_down;
output reg busy;
output reg [3:0] persons;

// reg [2:0] next_floor;
// reg [2:0] previus_floor;
reg door; // 0 is closed and 1 is open
reg [4:0] reqs;
integer i;

function [2:0] lsb;
    input [4:0] x;
    begin
        for (i = 1; i <= 5; i = i + 1) begin
            if (x[i - 1] == 1) begin
                lsb = i;
            end
        end
    end
endfunction

always @(posedge clk) begin
    if (reset) begin
        current_floor = 3'b001;
        going_up = 1'b0;
        going_down = 1'b0;    
        reqs = 5'b00000;
        persons = 0;
        door = CLOSED;
        busy = 1'b0;
    end
    else if (door == OPEN && (come_in || go_out)) begin
        persons = persons + come_in - go_out;
    end
    else if (reqs[current_floor - 1] == 1) begin
        door = OPEN;
        reqs[current_floor - 1] = 0;
    end
    else if (door == OPEN && reqs != 0 && persons <= 6) begin
        door = CLOSED;
    end
    else if (door == CLOSED && reqs != 0) begin
        if (current_floor == 5 || (going_down && (lsb(reqs) < current_floor))) begin
            current_floor = current_floor - 1;
            going_up = 1'b0;
            going_down = 1'b1;
            busy = 1;
        end
        else begin
            current_floor = current_floor + 1;
            going_up = 1'b1;
            going_down = 1'b0;
            busy = 1;
        end
    end
    else if (reqs == 0) begin
        busy = 1'b0;
        going_down = 0;
        going_up = 0;
    end
end


always @(buttons) begin
    reqs = reqs | buttons;
end

endmodule
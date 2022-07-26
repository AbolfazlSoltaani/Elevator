`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////

module Elevator(buttons, come_in, go_out, clk, reset, current_floor, going_up, going_down);

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

// reg [2:0] next_floor;
reg [2:0] previus_floor;
reg door; // 0 is closed and 1 is open
reg [4:0] reqs;
reg [3:0] persons;
integer i;

initial begin 
    current_floor = 3'b001;
    previus_floor = 3'b000;
    going_up = 1'b0;
    going_down = 1'b0;    
    reqs = 5'b00000;
    persons = 0;
    door = CLOSED;
end

always @(posedge clk) begin
    if (come_in || go_out) begin
        persons = persons + come_in - go_out;
    end
    else if (reqs[current_floor - 1] == 1) begin
        door = OPEN;
        going_up = 1'b0;
        going_down = 1'b0;        
        reqs[current_floor - 1] = 0;
    end
    else if (door == OPEN && reqs != 0 && persons <= 6) begin
        door = CLOSED;
    end
    else if (door == CLOSED && reqs != 0) begin
        if (current_floor == 1 || current_floor != 5 && previus_floor == current_floor - 1) begin
            previus_floor = current_floor;
            current_floor = current_floor + 1;
            going_up = 1'b1;
            going_down = 1'b0;
        end
        else begin
            previus_floor = current_floor;
            current_floor = current_floor - 1;
            going_up = 1'b0;
            going_down = 1'b1;
        end
    end
end


always @(buttons) begin
    reqs = reqs | buttons;
end

endmodule
`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator(input [4:0] buttons, input clk, input reset, output reg [2:0] current_floor);

// reg [2:0] next_floor;
reg [2:0] previus_floor;
reg door; // 0 is closed and 1 is open
reg [4:0] reqs;
reg [3:0] cap;
integer i;

initial begin 
    current_floor = 3'b000;
    previus_floor = 3'b000;
    reqs = 5'b00000;
    cap = 6;
    door = 0;
end

always @(posedge clk) begin
    if (reqs == 5'b00000) begin
        door = 0;
    end
    else if (door == 1) begin
        door = 0;
    end
    else if (reqs[current_floor] == 1) begin
        door = 1;
        reqs[current_floor] = 0;
    end
    else if (current_floor == 4 || (current_floor > 0 && previus_floor == current_floor + 1)) begin
        previus_floor = current_floor;
        current_floor = current_floor - 1;

    end
    else begin
        previus_floor = current_floor;
        current_floor = current_floor + 1;
    end
end


always @(buttons) begin
    reqs = reqs | buttons;
end

endmodule
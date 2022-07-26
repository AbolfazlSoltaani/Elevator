`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator(input [4:0] buttons, input clk, output reg [2:0] current_floor);

reg [2:0] next_floor;
reg [2:0] previus_floor;
reg [2:0] destination;
reg door; // 0 is closed and 1 is open
reg [4:0] reqs;
reg [3:0] cap;
integer i;

always @(posedge clk) begin
    door <= reqs[current_floor];
    previus_floor <= previus_floor == current_floor ? previus_floor : current_floor;
    current_floor <= next_floor;
    reqs[current_floor] <= 0;
end

always @(negedge door) begin
    if (!door)
        next_floor <= current_floor;
    else
        next_floor <= destination > current_floor ? current_floor + 1 : current_floor - 1;
    if (current_floor == 4 || previus_floor == current_floor + 1)
        destination <= current_floor - 1;
    else
        destination <= current_floor + 1;
end

// always @(negedge door) begin
//     if (current_floor == 4 || previus_floor == current_floor + 1)
//         destination <= current_floor - 1;
//     else
//         destination <= current_floor + 1;
// end

always @(buttons) begin
    reqs <= reqs | buttons;
end

always @(current_floor) begin
    $display("LL");
    door <= reqs[current_floor];
end

endmodule
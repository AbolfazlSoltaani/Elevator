`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HajarCO
// Engineer: Ali Rahmizad & Abolfazl Soltani 
// Module Name: Elevator_Controller
//////////////////////////////////////////////////////////////////////////////////


module Elevator(input [4:0] request_floors, );

integer current_floor = 0
reg [4:0] ins;
reg [4:0] outs;

always @(request_floors) begin
    ins = ins | request_floors
end

always @(current_floor) {
    if (outs[current_floor]) {
        outs[current_floor] = 0
        capacity = capacity - 1
        current_floor <- next_floor()
    }
    if (ins[current_floor])
        ins[current_floor] = 0
}

endmodule

// request_floors = 01000
// ins = 01000

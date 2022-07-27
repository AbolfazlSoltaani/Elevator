module Binary_To_7Segment (input clk, input [3:0] number,
   output Segment_A, output Segment_B, output Segment_C, output Segment_D, output Segment_E, output Segment_F, output Segment_G);
 
  reg [6:0] Hex_Encoding = 7'h00;
   
  
  always @(posedge clk)
    begin
      case (number)
        4'b0000 : Hex_Encoding <= 7'h7E;
        4'b0001 : Hex_Encoding <= 7'h30;
        4'b0010 : Hex_Encoding <= 7'h6D;
        4'b0011 : Hex_Encoding <= 7'h79;
        4'b0100 : Hex_Encoding <= 7'h33;          
        4'b0101 : Hex_Encoding <= 7'h5B;
        4'b0110 : Hex_Encoding <= 7'h5F;
        4'b0111 : Hex_Encoding <= 7'h70;
        4'b1000 : Hex_Encoding <= 7'h7F;
        4'b1001 : Hex_Encoding <= 7'h7B;
        4'b1010 : Hex_Encoding <= 7'h77;
        4'b1011 : Hex_Encoding <= 7'h1F;
        4'b1100 : Hex_Encoding <= 7'h4E;
        4'b1101 : Hex_Encoding <= 7'h3D;
        4'b1110 : Hex_Encoding <= 7'h4F;
        4'b1111 : Hex_Encoding <= 7'h47;
      endcase
    end
    
  assign Segment_A = Hex_Encoding[6];
  assign Segment_B = Hex_Encoding[5];
  assign Segment_C = Hex_Encoding[4];
  assign Segment_D = Hex_Encoding[3];
  assign Segment_E = Hex_Encoding[2];
  assign Segment_F = Hex_Encoding[1];
  assign Segment_G = Hex_Encoding[0];
 
endmodule

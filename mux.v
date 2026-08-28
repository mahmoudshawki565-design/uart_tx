module mux(
input [1:0] sel,
input serial_bit,parity_bit,
output reg TX_OUT
);

always @(*) begin
case(sel)

2'b00: TX_OUT=1'b0;
2'b01: TX_OUT=1'b1;
2'b10: TX_OUT=serial_bit;
2'b11: TX_OUT=parity_bit;
endcase
end

endmodule

module parity_calculator #(parameter n=8)
(
input CLK,RSTN,load,PAR_TYP,
input [n-1:0] P_DATA,
output reg parity_bit
);

always @(posedge CLK or negedge RSTN) begin
if(!RSTN)
        parity_bit<=1'b0;
    else if(load) begin
        if(PAR_TYP)
            parity_bit<=~(^P_DATA);
        else
            parity_bit<=^P_DATA;
    end
end

endmodule

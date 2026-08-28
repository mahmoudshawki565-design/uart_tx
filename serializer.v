module serializer #(parameter n=8)
(
input CLK,RSTN,load,shift,
input [n-1:0] P_DATA,
output serial_bit,
output reg data_done
);

reg [n-1:0] shift_reg;
reg [$clog2(n)-1:0] cnt;

assign serial_bit=shift_reg[0];

always @(posedge CLK or negedge RSTN) begin
if(!RSTN) begin
        shift_reg<=0;
        cnt<=0;
        data_done<=1'b0;
    end
    else begin
        data_done<=1'b0;

        if(load) begin
            shift_reg<=P_DATA;
            cnt<=0;
        end
        else if(shift) begin
           if(cnt == n-1) begin
        cnt <= 0;
    end
    else begin
        shift_reg <= shift_reg >> 1; 
        cnt <= cnt + 1'b1;
    end

    if(cnt == n-2) data_done <= 1'b1; 
end
end
end

endmodule

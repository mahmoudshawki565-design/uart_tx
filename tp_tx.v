`timescale 1ns/1ps

module tb_uart_tx();

parameter N = 8;

reg CLK;
reg RSTN;
reg PAR_EN;
reg PAR_TYP;
reg DATA_VALID;
reg [N-1:0] P_DATA;

wire TX_OUT;
wire BUSY;

uart_tx #(.n(N)) DUT(
.CLK(CLK),
.RSTN(RSTN),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.DATA_VALID(DATA_VALID),
.P_DATA(P_DATA),
.TX_OUT(TX_OUT),
.BUSY(BUSY)
);

always #5 CLK = ~CLK;

always @(posedge CLK) begin
    if(BUSY || DATA_VALID) begin

        $display("Time=%0t ps | BUSY=%b | TX_OUT=%b", $time, BUSY, TX_OUT);
    end
end

initial begin
CLK = 0;
RSTN = 0;   
PAR_EN = 0;
PAR_TYP = 0;
DATA_VALID = 0;
P_DATA = 8'h00;


#15 RSTN = 1;
#10;

    $display("\n--- [Test 1] Data = 8'b1010_1101 | Parity ON (Even) ---");

@(posedge CLK);
P_DATA = 8'b10101101;
PAR_EN = 1'b1;
PAR_TYP = 1'b0;
DATA_VALID = 1'b1;

@(posedge CLK);
DATA_VALID = 1'b0;

wait(BUSY == 1'b1);
wait(BUSY == 1'b0);
    #30;

   $display("\n--- [Test 2] Data = 8'b1111_0000 | Parity OFF ---");

@(posedge CLK);
P_DATA = 8'b11110000;
PAR_EN = 1'b0;
DATA_VALID = 1'b1;

@(posedge CLK);
DATA_VALID = 1'b0;
wait(BUSY == 1'b1);
wait(BUSY == 1'b0);
#30;

    $display("\n--- [Test 3] Data = 8'b0101_0101 | Parity ON (Odd) ---");
    $display("\n=== Simulation Finished Successfully ===");
    $finish;
end

endmodule


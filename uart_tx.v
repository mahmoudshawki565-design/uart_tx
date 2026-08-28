module uart_tx #(parameter n=8)
(
input CLK,RSTN,PAR_EN,PAR_TYP,DATA_VALID,
input[n-1:0] P_DATA,
output TX_OUT,BUSY
);

wire load,shift;
wire [1:0] mux_sel;
wire serial_bit,parity_bit,data_done;

uart_controller CONTROLLER(
.CLK(CLK),
.RSTN(RSTN),
.DATA_VALID(DATA_VALID),
.PAR_EN(PAR_EN),
.data_done(data_done),
.load(load),
.shift(shift),
.mux_sel(mux_sel),
.BUSY(BUSY)
);

serializer #(.n(n)) SERIALIZER(
.CLK(CLK),
.RSTN(RSTN),
.load(load),
.shift(shift),
.P_DATA(P_DATA),
.serial_bit(serial_bit),
.data_done(data_done)
);

parity_calculator #(.n(n)) PARITY_CALCULATOR(
.CLK(CLK),
.RSTN(RSTN),
.load(load),
.P_DATA(P_DATA),
.PAR_TYP(PAR_TYP),
.parity_bit(parity_bit)
);

mux MUX(
.sel(mux_sel),
.serial_bit(serial_bit),
.parity_bit(parity_bit),
.TX_OUT(TX_OUT)
);

endmodule

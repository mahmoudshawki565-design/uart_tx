module uart_controller(
input CLK,RSTN,DATA_VALID,PAR_EN,data_done,
output reg load,shift,BUSY,
output reg [1:0]mux_sel
   
);

localparam 
START = 2'b00,
DATA  = 2'b01,
PARITY= 2'b10,
STOP  = 2'b11;
reg [1:0] cu_state,next_state;

always @(*) begin
next_state = cu_state;

case(cu_state)
START: next_state = DATA;

DATA: begin
if(data_done)
   next_state = PAR_EN ? PARITY : STOP;
end

PARITY: next_state = STOP;

STOP: begin
if(DATA_VALID)
   next_state = START;
end

default: next_state = STOP;
endcase
end

always @(*) begin
load=1'b0;
shift=1'b0;
mux_sel=2'b01;
BUSY=1'b1;

case(cu_state)

START: mux_sel=2'b00;

DATA: begin
mux_sel = 2'b10;
shift = 1'b1;
end

PARITY: mux_sel = 2'b11;

STOP: begin
mux_sel = 2'b01;
BUSY=1'b0;
if(DATA_VALID)
load = 1'b1;
end
endcase
end

always @(posedge CLK or negedge RSTN) begin
if(!RSTN)
cu_state <= STOP;
else
cu_state<=next_state;
end

endmodule

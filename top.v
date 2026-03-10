module mux4_4(
	input [3:0] CEO,
	input [3:0] YOU,
	input [3:0] FRED,
	input [3:0] JILL,
	input [1:0] sel,
	input Enable,
	output [3:0] Y
);

assign Y = Enable ? (sel==0 ? CEO:
sel==1 ? YOU:
sel==2 ? FRED:
sel==3 ? JILL: 0):0;

endmodule 

module demux_4(
    input [3:0] In,
    input [1:0] Sel,
    input Enable,
    output [3:0] local_lib,
    output [3:0] fire_dept,
    output [3:0] school,
    output [3:0] rib_shack
);

assign local_lib = (Enable && Sel == 2'b00 ? In : 0);
assign fire_dept = (Enable && Sel == 2'b01 ? In : 0);
assign school = (Enable && Sel == 2'b10 ? In : 0);
assign rib_shack = (Enable && Sel == 2'b11 ? In : 0);

endmodule

module top(
    input [15:0]sw,
    output [15:0]led,
    input btnL, btnU, btnD, btnR, btnC
);

wire [3:0] internet;

wire [1:0] mux_sel;
wire [1:0] demux_sel;

assign mux_sel = {btnU, btnL};
assign demux_sel = {btnR, btnD};

mux4_4 mux_inst(
    .CEO(sw[3:0]),
    .YOU(sw[7:4]),
    .FRED(sw[11:8]),
    .JILL(sw[15:12]),
    .sel(mux_sel),
    .Enable(btnC),
    .Y(internet)
);

demux_4 demux_inst(
    .In(internet),
    .Sel(demux_sel),
    .Enable(btnC),
    .local_lib(led[3:0]),
    .fire_dept(led[7:4]),
    .school(led[11:8]),
    .rib_shack(led[15:12])
);

endmodule
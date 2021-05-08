/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	G:/example/FIFO_example1/al_ip/U_FIFO.v
 ** Date	:	2021 05 01
 ** TD version	:	5.0.27252
\************************************************************/

`timescale 1ns / 1ps

module U_FIFO(dout, empty_flag, full_flag, fifo_wrpointer, fifo_rdpointer,
	wrst, rrst, di, clk, we, re);

    input                         wrst;
    input                         rrst;
    input         [7:0]           di;
    input                         clk;
    input                         we;
    input                         re;
    output        [7:0]           dout;
    output                        empty_flag;
    output                        full_flag;
    output        [8:0]           fifo_wrpointer;
    output        [8:0]           fifo_rdpointer;
    PH1_LOGIC_FIFO #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(9),
        .REGMODE_W("NOREG"),
        .REGMODE_R("NOREG"),
        .ASYNC_RESET_RELEASE("SYNC"),
        .CLKMODE("SYNC"),
        .SSROVERCE("DISABLE"),
        .ECC_ENCODE("DISABLE"),
        .ECC_DECODE("DISABLE"))
    fifo_inst (
		.wrst(wrst),
		.rrst(rrst),
		.di(di),
		.clkw(clk),
		.we(we),
		.csw(3'b111),
		.dout(dout),
		.clkr(clk),
		.re(re),
		.csr(3'b111),
		.empty_flag(empty_flag),
		.aempty_flag(),
		.full_flag(full_flag),
		.afull_flag(),
		.ecc_sbiterr(),
		.ecc_dbiterr(),
		.fifo_wrpointer(fifo_wrpointer),
		.fifo_rdpointer(fifo_rdpointer)
		);
endmodule

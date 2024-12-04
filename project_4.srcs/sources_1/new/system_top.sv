`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 17:03:50
// Design Name: 
// Module Name: system_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module system_top (
    input logic clk,
    input logic reset,
    input logic start,
    input logic seq_select,          // 0: Recamán, 1: Newman-Conway
    output logic done,               // Señal de finalización
    output logic [15:0] sequence_out // Salida de la secuencia
);

    logic enable_calculate, write_enable;
    logic [7:0] write_address;

    // Instancia de la Unidad de Control
    control_unit control (
        .clk(clk),
        .reset(reset),
        .start(start),
        .seq_select(seq_select),
        .enable_calculate(enable_calculate),
        .write_enable(write_enable),
        .write_address(write_address),
        .done(done)
    );

    // Instancia del Datapath
    datapath data (
        .clk(clk),
        .reset(reset),
        .enable_calculate(enable_calculate),
        .write_enable(write_enable),
        .seq_select(seq_select),
        .write_address(write_address),
        .sequence_out(sequence_out)
    );

endmodule

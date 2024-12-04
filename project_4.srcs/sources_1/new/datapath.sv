`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 18:20:47
// Design Name: 
// Module Name: datapath
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


module datapath (
    input logic clk,
    input logic reset,
    input logic enable_calculate,
    input logic write_enable,
    input logic seq_select,           // 0: Recamán, 1: Newman-Conway
    input logic [7:0] write_address,  // Dirección actual
    output logic [15:0] sequence_out  // Salida de la secuencia seleccionada
);

    logic [15:0] recaman_out, newman_out;
    logic [15:0] memory_out;

    // Módulo Recamán
    recaman_sequence recaman (
        .clk(clk),
        .reset(reset),
        .enable(enable_calculate && (seq_select == 1'b0)),
        .n(write_address),
        .next(recaman_out)
    );

    // Módulo Newman-Conway
    newman_sequence newman (
        .clk(clk),
        .reset(reset),
        .enable(enable_calculate && (seq_select == 1'b1)),
        .n(write_address),
        .next(newman_out)
    );

    // Memoria Compartida
    shared_memory memory (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_address(write_address),
        .write_data((seq_select == 1'b0) ? recaman_out : newman_out), // Dato a escribir
        .read_data(memory_out) // Dato leído
    );

    // Depuración: Muestra las entradas y salidas
    initial begin
        $monitor("Recaman_Out=%d | Newman_Out=%d | Memory_Out=%d | Sequence_Select=%b", 
                 recaman_out, newman_out, memory_out, seq_select);
    end

    // La salida final es el dato almacenado en la memoria
    assign sequence_out = memory_out;

endmodule

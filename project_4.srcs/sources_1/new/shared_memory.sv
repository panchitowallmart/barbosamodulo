`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 15:50:07
// Design Name: 
// Module Name: shared_memory
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


module shared_memory (
    input logic clk,
    input logic reset,
    input logic write_enable,
    input logic [7:0] write_address, // Dirección para escribir
    input logic [15:0] write_data,   // Datos a escribir
    output logic [15:0] read_data    // Datos leídos
);

    logic [15:0] memory [0:255]; // Memoria de 256 palabras de 16 bits

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 256; i++) begin
                memory[i] <= 16'd0;
            end
        end else if (write_enable) begin
            memory[write_address] <= write_data;
        end
    end

    assign read_data = memory[write_address];

endmodule

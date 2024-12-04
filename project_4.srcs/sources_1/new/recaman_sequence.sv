`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 13:37:40
// Design Name: 
// Module Name: recaman_sequence
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

module recaman_sequence (
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [7:0] n,
    output logic [15:0] next
);
    logic [15:0] recaman_array [0:255]; // Arreglo para almacenar la secuencia

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next <= 16'd0;
        end else if (enable) begin
            if (n == 0) begin
                next <= 16'd0;
            end else begin
                if (recaman_array[n-1] > n && recaman_array[n-1] - n != recaman_array[n]) begin
                    next <= recaman_array[n-1] - n;
                end else begin
                    next <= recaman_array[n-1] + n;
                end
            end
            recaman_array[n] <= next;
        end else begin
            next <= 16'd0; // Forzar a 0 cuando no está habilitado
        end
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 14:59:11
// Design Name: 
// Module Name: newman_sequence
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

module newman_sequence (
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [7:0] n,
    output logic [15:0] next
);
    logic [15:0] newman_array [0:255]; // Arreglo para almacenar la secuencia

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next <= 16'd0;
            newman_array[1] <= 16'd1;
            newman_array[2] <= 16'd1;
        end else if (enable) begin
            if (n == 1 || n == 2) begin
                next <= 16'd1;
            end else begin
                next <= newman_array[newman_array[n-1]] + newman_array[n-newman_array[n-1]];
            end
            newman_array[n] <= next;
        end else begin
            next <= 16'd0; // Forzar a 0 cuando no está habilitado
        end
    end
endmodule

`timescale 1ns / 1ps

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
        end
    end
endmodule

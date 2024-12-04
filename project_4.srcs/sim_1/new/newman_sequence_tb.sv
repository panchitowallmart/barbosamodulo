`timescale 1ns / 1ps
module newman_sequence_tb;
    // Señales
    logic clk;
    logic reset;
    logic enable;
    logic [7:0] n;
    logic [15:0] next;

    // Instancia del módulo
    newman_sequence uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .n(n),
        .next(next)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Monitor detallado
    initial begin
        $monitor("Time=%t | reset=%b, enable=%b, n=%d | next=%d", 
                 $time, reset, enable, n, next);
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        reset = 1;
        enable = 0;
        n = 0;

        // Reinicio
        #10 reset = 0;
        
        // Prueba de Newman-Conway
        enable = 1;
        repeat (16) begin
            #10 n = n + 1; // Incrementar el índice
        end

        enable = 0;
        #10 $display("Simulation completed");
        $finish;
    end
endmodule

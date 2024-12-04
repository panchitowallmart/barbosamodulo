`timescale 1ns / 1ps
module system_top_tb;
    // Señales
    logic clk;
    logic reset;
    logic start;
    logic seq_select;
    logic done;
    logic [15:0] sequence_out;

    // Instancia del sistema principal
    system_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .seq_select(seq_select),
        .done(done),
        .sequence_out(sequence_out)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Monitor detallado
    initial begin
        $monitor("Time=%t | reset=%b, start=%b, seq_select=%b | sequence_out=%d | done=%b", 
                 $time, reset, start, seq_select, sequence_out, done);
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        reset = 1;
        start = 0;
        seq_select = 0;

        // Reinicio
        #10 reset = 0;

        // Prueba de Recamán
        start = 1;
        seq_select = 0; // Seleccionar Recamán
        #300;

        // Cambiar a Newman-Conway
        seq_select = 1; // Cambiar a Newman-Conway
        #300;

        $display("Simulation completed");
        $finish;
    end
endmodule

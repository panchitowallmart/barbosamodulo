`timescale 1ns / 1ps
module control_unit_tb;
    // Señales
    logic clk;
    logic reset;
    logic start;
    logic seq_select;
    logic enable_recaman;
    logic enable_newman;
    logic write_enable;
    logic [7:0] write_address;
    logic done;

    // Instancia de la unidad de control
    control_unit uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .seq_select(seq_select),
        .enable_recaman(enable_recaman),
        .enable_newman(enable_newman),
        .write_enable(write_enable),
        .write_address(write_address),
        .done(done)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Monitor detallado
    initial begin
        $monitor("Time=%t | reset=%b, start=%b, seq_select=%b | enable_recaman=%b, enable_newman=%b | write_address=%d | write_enable=%b | done=%b", 
                 $time, reset, start, seq_select, enable_recaman, enable_newman, write_address, write_enable, done);
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

`timescale 1ns / 1ps

module shared_memory_tb;

    // Señales
    logic clk;
    logic reset;
    logic write_enable;
    logic [7:0] write_address;
    logic [7:0] read_address;
    logic [15:0] write_data;
    logic [15:0] read_data;

    // Instancia del módulo de memoria
    shared_memory uut (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_address(write_address),
        .read_address(read_address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        reset = 1;
        write_enable = 0;
        write_address = 0;
        read_address = 0;
        write_data = 0;

        #20 reset = 0; // Esperar 20 ns para permitir que el reset se estabilice

        // Escribir valores en la memoria
        for (int i = 0; i < 10; i++) begin
            write_enable = 1;
            write_address = i;
            write_data = i * 2; // Escribir el doble del índice
            #10;                // Ciclo de reloj para la escritura
        end
        write_enable = 0;

        // Leer valores desde la memoria
        #10; // Esperar un ciclo para estabilizar
        for (int i = 0; i < 10; i++) begin
            read_address = i;
            #10; // Ciclo de reloj para la lectura
            $display("READ: Address=%0d, Data=%0d", read_address, read_data);
        end

        $finish; // Finalizar la simulación
    end

endmodule

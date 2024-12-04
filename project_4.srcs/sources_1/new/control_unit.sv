`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 16:09:00
// Design Name: 
// Module Name: control_unit
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

module control_unit (
    input logic clk,
    input logic reset,
    input logic start,
    input logic seq_select,           // 0: Recamán, 1: Newman-Conway
    output logic enable_calculate,   // Habilitar cálculo
    output logic write_enable,       // Habilitar escritura
    output logic [7:0] write_address,// Dirección de escritura
    output logic done                // Señal de finalización
);

    typedef enum logic [1:0] {
        IDLE,
        CALCULATE,
        WRITE,
        DONE
    } state_t;

    state_t state, next_state;
    logic [7:0] counter; // Contador para las direcciones de escritura

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
        end else begin
            state <= next_state;
            if (state == WRITE && counter < 8'd15) begin
                counter <= counter + 1;
            end else if (state == DONE) begin
                counter <= 8'd0;
            end
        end
    end

    always_comb begin
        // Valores por defecto
        next_state = state;
        enable_calculate = 1'b0;
        write_enable = 1'b0;
        write_address = counter;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (start) next_state = CALCULATE;
            end
            CALCULATE: begin
                enable_calculate = 1'b1;
                next_state = WRITE;
            end
            WRITE: begin
                write_enable = 1'b1;
                if (counter == 8'd14) next_state = DONE;
                else next_state = CALCULATE;
            end
            DONE: begin
                done = 1'b1;
                if (!start) next_state = IDLE;
            end
        endcase
    end

endmodule

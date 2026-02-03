/*
 * Simple FSM - IEEE 1364-2005 synthesizable subset
 * Combinational next-state and output; sequential state register.
 * full_case/parallel_case via default to avoid latch.
 */

module fsm_2005 (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       go,
    input  wire       done,
    output reg  [1:0] state,
    output reg        busy
);
    localparam S_IDLE  = 2'd0;
    localparam S_RUN   = 2'd1;
    localparam S_DONE  = 2'd2;

    reg [1:0] next_state;

    /* Combinational: next state and output (blocking) */
    always @* begin
        next_state = state;
        busy = 1'b0;
        case (state)
            S_IDLE: begin
                busy = 1'b0;
                next_state = go ? S_RUN : S_IDLE;
            end
            S_RUN: begin
                busy = 1'b1;
                next_state = done ? S_DONE : S_RUN;
            end
            S_DONE: begin
                busy = 1'b0;
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
                busy = 1'b0;
            end
        endcase
    end

    /* Sequential: state register (nonblocking) */
    always @(posedge clk) begin
        if (!rst_n)
            state <= S_IDLE;
        else
            state <= next_state;
    end
endmodule

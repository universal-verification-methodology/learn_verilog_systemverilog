/*
 * Small FSM with immediate assertion - IEEE 1800-2009/2012
 * One-hot state encoding; assert one-hot in design.
 */

module small_fsm_sv (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       go,
    input  logic       done,
    output logic [2:0] state,
    output logic       busy
);
    localparam S_IDLE = 3'b001;
    localparam S_RUN  = 3'b010;
    localparam S_DONE = 3'b100;

    logic [2:0] next_state;

    always_comb begin
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
            default: next_state = S_IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    /* Immediate assertion: state must be one-hot or idle (2009/2012) */
    always_comb
        assert ($countones(state) <= 1) else $error("FSM state not one-hot: %b", state);
endmodule

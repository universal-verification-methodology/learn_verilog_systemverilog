/*
 * FSM - IEEE 1800-2017 design subset
 * unique case, always_ff, one immediate assertion (state encoding).
 */

module fsm_2017 (
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    output logic [2:0] state,
    output logic       busy
);
    localparam S_IDLE = 3'b001, S_RUN = 3'b010, S_DONE = 3'b100;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            busy  <= 1'b0;
        end else begin
            unique case (state)
                S_IDLE: begin
                    state <= start ? S_RUN : S_IDLE;
                    busy  <= start ? 1'b1 : 1'b0;
                end
                S_RUN: begin
                    state <= S_DONE;
                    busy  <= 1'b1;
                end
                S_DONE: begin
                    state <= S_IDLE;
                    busy  <= 1'b0;
                end
                default: begin
                    state <= S_IDLE;
                    busy  <= 1'b0;
                end
            endcase
        end
    end

    /* Immediate assertion: state must be one-hot or zero */
    always_comb begin
        assert ($countones(state) <= 1)
            else $error("fsm_2017: state not one-hot: %b", state);
    end
endmodule

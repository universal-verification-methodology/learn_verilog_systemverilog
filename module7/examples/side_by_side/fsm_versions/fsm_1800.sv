/*
 * Module 7: Tiny FSM (2 states) - 1800-2005/2017
 * always_ff, unique case; same behavior.
 */

module fsm_1800 (
    input  logic       clk, rst_n, go,
    output logic [1:0] state,
    output logic       done
);
    localparam logic [1:0] S0 = 2'b01, S1 = 2'b10;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state <= S0;
            done  <= 1'b0;
        end else begin
            unique case (state)
                S0: begin
                    state <= go ? S1 : S0;
                    done  <= 1'b0;
                end
                S1: begin
                    state <= S0;
                    done  <= 1'b1;
                end
                default: begin state <= S0; done <= 1'b0; end
            endcase
        end
    end
endmodule

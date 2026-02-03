/*
 * Module 7: Tiny FSM (2 states) - 1364-2001/2005
 * always @(posedge clk), case; same behavior.
 */

module fsm_1364 (
    input  wire       clk, rst_n, go,
    output reg  [1:0] state,
    output reg        done
);
    localparam S0 = 2'b01, S1 = 2'b10;
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= S0;
            done  <= 0;
        end else begin
            case (state)
                S0: begin
                    state <= go ? S1 : S0;
                    done  <= 0;
                end
                S1: begin
                    state <= S0;
                    done  <= 1;
                end
                default: begin state <= S0; done <= 0; end
            endcase
        end
    end
endmodule

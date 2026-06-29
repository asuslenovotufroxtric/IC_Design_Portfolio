
module regn #(parameter n = 9) (
    input  logic [n-1:0] R,
    input  logic Rin, Clock,
    output logic [n-1:0] Q
);
    always_ff @(posedge Clock) begin
        if (Rin) Q <= R;
    end
endmodule

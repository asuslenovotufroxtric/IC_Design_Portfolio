module dec3to8 (
    input  logic [2:0] W,
    input  logic En,
    output logic [7:0] Y 
);
    always_comb begin
        if (!En) Y = 8'b0;
        else begin
            case (W)
                3'b000: Y = 8'b0000_0001; // R0
                3'b001: Y = 8'b0000_0010; // R1
                3'b010: Y = 8'b0000_0100; // R2
                3'b011: Y = 8'b0000_1000; // R3
                3'b100: Y = 8'b0001_0000; // R4
                3'b101: Y = 8'b0010_0000; // R5
                3'b110: Y = 8'b0100_0000; // R6
                3'b111: Y = 8'b1000_0000; // R7
                default: Y = 8'b0;
            endcase
        end
    end
endmodule

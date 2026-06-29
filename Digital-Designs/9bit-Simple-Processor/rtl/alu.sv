module alu (
input logic [8:0] A, B,
input logic Sub ,
output logic [8:0] S
        );
 always_comb begin
 if ( Sub ) S = A - B;
       else S = A + B;
            end
endmodule

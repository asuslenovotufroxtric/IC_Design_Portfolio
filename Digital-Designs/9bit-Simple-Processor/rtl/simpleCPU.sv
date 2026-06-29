module simpleCPU (
    input  logic [8:0] DIN,     
    input  logic       Resetn, 
    input  logic       Clock, 
    input  logic       Run,
    output logic       Done,    
    output logic [8:0] BusWires, 
    output logic [1:0] Tstep_View, 
    output logic [8:0] R0_Q, R1_Q, R2_Q, R3_Q, 
    output logic [8:0] R4_Q, R5_Q, R6_Q, R7_Q,
    output logic [8:0] A_Q, G_Q, 
    output logic [8:0] IR_Q
);

    logic [7:0] Rin_HotOne, Rout_HotOne;
    logic [7:0] Xreg, Yreg;
    logic IRin, DINout, Ain, Gin, Gout, AddSub;
    logic [8:0] Alu_Result;
    
    typedef enum logic [1:0] {T0=2'b00, T1=2'b01, T2=2'b10, T3=2'b11} state_t;
    state_t Tstep_Q, Tstep_D;
    
    logic [2:0] I, X, Y;

    assign Tstep_View = Tstep_Q; 

    assign I = IR_Q[8:6];
    assign X = IR_Q[5:3];
    assign Y = IR_Q[2:0];

    dec3to8 decX (.W(X), .En(1'b1), .Y(Xreg));
    dec3to8 decY (.W(Y), .En(1'b1), .Y(Yreg));

    // DATAPATH
    regn reg_R0 (.R(BusWires), .Rin(Rin_HotOne[0]), .Clock(Clock), .Q(R0_Q));
    regn reg_R1 (.R(BusWires), .Rin(Rin_HotOne[1]), .Clock(Clock), .Q(R1_Q));
    regn reg_R2 (.R(BusWires), .Rin(Rin_HotOne[2]), .Clock(Clock), .Q(R2_Q));
    regn reg_R3 (.R(BusWires), .Rin(Rin_HotOne[3]), .Clock(Clock), .Q(R3_Q));
    regn reg_R4 (.R(BusWires), .Rin(Rin_HotOne[4]), .Clock(Clock), .Q(R4_Q));
    regn reg_R5 (.R(BusWires), .Rin(Rin_HotOne[5]), .Clock(Clock), .Q(R5_Q));
    regn reg_R6 (.R(BusWires), .Rin(Rin_HotOne[6]), .Clock(Clock), .Q(R6_Q));
    regn reg_R7 (.R(BusWires), .Rin(Rin_HotOne[7]), .Clock(Clock), .Q(R7_Q));
    regn reg_A  (.R(BusWires), .Rin(Ain),  .Clock(Clock), .Q(A_Q));
    regn reg_IR (.R(DIN),      .Rin(IRin), .Clock(Clock), .Q(IR_Q)); 
    regn reg_G  (.R(Alu_Result), .Rin(Gin),.Clock(Clock), .Q(G_Q));
	 
    alu U_ALU (.A(A_Q), .B(BusWires), .Sub(AddSub), .S(Alu_Result));

    // MUX
    always_comb begin
        if (DINout)              BusWires = DIN;
        else if (Gout)           BusWires = G_Q;
        else if (Rout_HotOne[0]) BusWires = R0_Q;
        else if (Rout_HotOne[1]) BusWires = R1_Q;
        else if (Rout_HotOne[2]) BusWires = R2_Q;
        else if (Rout_HotOne[3]) BusWires = R3_Q;
        else if (Rout_HotOne[4]) BusWires = R4_Q;
        else if (Rout_HotOne[5]) BusWires = R5_Q;
        else if (Rout_HotOne[6]) BusWires = R6_Q;
        else if (Rout_HotOne[7]) BusWires = R7_Q;
        else BusWires = 9'b0;
    end

    // CONTROL UNIT (FSM)
    always_ff @(posedge Clock or negedge Resetn) begin
        if (!Resetn) Tstep_Q <= T0;
        else         Tstep_Q <= Tstep_D;
    end

    always_comb begin
        case (Tstep_Q)
            T0: begin
                if (!Run) Tstep_D = T0;
                else      Tstep_D = T1;
            end
            T1: begin
                if (Done) Tstep_D = T0; 
                else      Tstep_D = T2;
            end
            T2: begin
                Tstep_D = T3;
            end
            T3: begin
                Tstep_D = T0;
            end
            default: Tstep_D = T0;
        endcase
    end

    always_comb begin
        Done = 0; IRin = 0; DINout = 0; Ain = 0; Gin = 0; Gout = 0; AddSub = 0;
        Rin_HotOne = 8'b0; Rout_HotOne = 8'b0;

        case (Tstep_Q)
            T0: begin
                IRin = 1; 
					 DINout = 1;
            end

            T1: begin
                case (I)
                    3'b000: begin 
                        Rout_HotOne = Yreg; 
                        Rin_HotOne = Xreg; 
                        Done = 1; 
                    end
                    3'b001: begin 
                        DINout = 1; 
                        Rin_HotOne = Xreg; 
                        Done = 1; 
                    end
                    3'b010, 3'b011: begin 
                        Rout_HotOne = Xreg; 
                        Ain = 1; 
                    end
                endcase
            end

            T2: begin
                case (I)
                    3'b010: begin 
                        Rout_HotOne = Yreg; 
                        Gin = 1; 
                    end
                    3'b011: begin 
                        Rout_HotOne = Yreg; 
                        Gin = 1; 
                        AddSub = 1; 
                    end
                endcase
            end

            T3: begin 
                case (I)
                    3'b010, 3'b011: begin
                        Gout = 1; 
                        Rin_HotOne = Xreg; 
                        Done = 1; 
                    end
                endcase
            end
        endcase
    end
endmodule

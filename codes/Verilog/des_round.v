`timescale 1ns/1ps

module des_round (
    input wire [63:0] state_in,
    input wire [47:0] round_key,
    output wire [63:0] state_out
);
    wire [31:0] left_in = state_in[63:32];
    wire [31:0] right_in = state_in[31:0];
    wire [47:0] expanded;
    wire [47:0] mixed;
    wire [31:0] substituted;
    wire [31:0] f_out;

    assign expanded = {
        right_in[0], right_in[31], right_in[30], right_in[29], right_in[28], right_in[27],
        right_in[28], right_in[27], right_in[26], right_in[25], right_in[24], right_in[23],
        right_in[24], right_in[23], right_in[22], right_in[21], right_in[20], right_in[19],
        right_in[20], right_in[19], right_in[18], right_in[17], right_in[16], right_in[15],
        right_in[16], right_in[15], right_in[14], right_in[13], right_in[12], right_in[11],
        right_in[12], right_in[11], right_in[10], right_in[9], right_in[8], right_in[7],
        right_in[8], right_in[7], right_in[6], right_in[5], right_in[4], right_in[3],
        right_in[4], right_in[3], right_in[2], right_in[1], right_in[0], right_in[31]
    };
    assign mixed = expanded ^ round_key;

    function [3:0] sbox;
        input [2:0] box_id;
        input [5:0] six;
        reg [5:0] address;
        begin
            address = {six[5], six[0], six[4:1]};
            sbox = 4'h0;
            case (box_id)
                3'd0: begin
                    case (address)
                        6'd0: sbox = 4'hE;
                        6'd1: sbox = 4'h4;
                        6'd2: sbox = 4'hD;
                        6'd3: sbox = 4'h1;
                        6'd4: sbox = 4'h2;
                        6'd5: sbox = 4'hF;
                        6'd6: sbox = 4'hB;
                        6'd7: sbox = 4'h8;
                        6'd8: sbox = 4'h3;
                        6'd9: sbox = 4'hA;
                        6'd10: sbox = 4'h6;
                        6'd11: sbox = 4'hC;
                        6'd12: sbox = 4'h5;
                        6'd13: sbox = 4'h9;
                        6'd14: sbox = 4'h0;
                        6'd15: sbox = 4'h7;
                        6'd16: sbox = 4'h0;
                        6'd17: sbox = 4'hF;
                        6'd18: sbox = 4'h7;
                        6'd19: sbox = 4'h4;
                        6'd20: sbox = 4'hE;
                        6'd21: sbox = 4'h2;
                        6'd22: sbox = 4'hD;
                        6'd23: sbox = 4'h1;
                        6'd24: sbox = 4'hA;
                        6'd25: sbox = 4'h6;
                        6'd26: sbox = 4'hC;
                        6'd27: sbox = 4'hB;
                        6'd28: sbox = 4'h9;
                        6'd29: sbox = 4'h5;
                        6'd30: sbox = 4'h3;
                        6'd31: sbox = 4'h8;
                        6'd32: sbox = 4'h4;
                        6'd33: sbox = 4'h1;
                        6'd34: sbox = 4'hE;
                        6'd35: sbox = 4'h8;
                        6'd36: sbox = 4'hD;
                        6'd37: sbox = 4'h6;
                        6'd38: sbox = 4'h2;
                        6'd39: sbox = 4'hB;
                        6'd40: sbox = 4'hF;
                        6'd41: sbox = 4'hC;
                        6'd42: sbox = 4'h9;
                        6'd43: sbox = 4'h7;
                        6'd44: sbox = 4'h3;
                        6'd45: sbox = 4'hA;
                        6'd46: sbox = 4'h5;
                        6'd47: sbox = 4'h0;
                        6'd48: sbox = 4'hF;
                        6'd49: sbox = 4'hC;
                        6'd50: sbox = 4'h8;
                        6'd51: sbox = 4'h2;
                        6'd52: sbox = 4'h4;
                        6'd53: sbox = 4'h9;
                        6'd54: sbox = 4'h1;
                        6'd55: sbox = 4'h7;
                        6'd56: sbox = 4'h5;
                        6'd57: sbox = 4'hB;
                        6'd58: sbox = 4'h3;
                        6'd59: sbox = 4'hE;
                        6'd60: sbox = 4'hA;
                        6'd61: sbox = 4'h0;
                        6'd62: sbox = 4'h6;
                        6'd63: sbox = 4'hD;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd1: begin
                    case (address)
                        6'd0: sbox = 4'hF;
                        6'd1: sbox = 4'h1;
                        6'd2: sbox = 4'h8;
                        6'd3: sbox = 4'hE;
                        6'd4: sbox = 4'h6;
                        6'd5: sbox = 4'hB;
                        6'd6: sbox = 4'h3;
                        6'd7: sbox = 4'h4;
                        6'd8: sbox = 4'h9;
                        6'd9: sbox = 4'h7;
                        6'd10: sbox = 4'h2;
                        6'd11: sbox = 4'hD;
                        6'd12: sbox = 4'hC;
                        6'd13: sbox = 4'h0;
                        6'd14: sbox = 4'h5;
                        6'd15: sbox = 4'hA;
                        6'd16: sbox = 4'h3;
                        6'd17: sbox = 4'hD;
                        6'd18: sbox = 4'h4;
                        6'd19: sbox = 4'h7;
                        6'd20: sbox = 4'hF;
                        6'd21: sbox = 4'h2;
                        6'd22: sbox = 4'h8;
                        6'd23: sbox = 4'hE;
                        6'd24: sbox = 4'hC;
                        6'd25: sbox = 4'h0;
                        6'd26: sbox = 4'h1;
                        6'd27: sbox = 4'hA;
                        6'd28: sbox = 4'h6;
                        6'd29: sbox = 4'h9;
                        6'd30: sbox = 4'hB;
                        6'd31: sbox = 4'h5;
                        6'd32: sbox = 4'h0;
                        6'd33: sbox = 4'hE;
                        6'd34: sbox = 4'h7;
                        6'd35: sbox = 4'hB;
                        6'd36: sbox = 4'hA;
                        6'd37: sbox = 4'h4;
                        6'd38: sbox = 4'hD;
                        6'd39: sbox = 4'h1;
                        6'd40: sbox = 4'h5;
                        6'd41: sbox = 4'h8;
                        6'd42: sbox = 4'hC;
                        6'd43: sbox = 4'h6;
                        6'd44: sbox = 4'h9;
                        6'd45: sbox = 4'h3;
                        6'd46: sbox = 4'h2;
                        6'd47: sbox = 4'hF;
                        6'd48: sbox = 4'hD;
                        6'd49: sbox = 4'h8;
                        6'd50: sbox = 4'hA;
                        6'd51: sbox = 4'h1;
                        6'd52: sbox = 4'h3;
                        6'd53: sbox = 4'hF;
                        6'd54: sbox = 4'h4;
                        6'd55: sbox = 4'h2;
                        6'd56: sbox = 4'hB;
                        6'd57: sbox = 4'h6;
                        6'd58: sbox = 4'h7;
                        6'd59: sbox = 4'hC;
                        6'd60: sbox = 4'h0;
                        6'd61: sbox = 4'h5;
                        6'd62: sbox = 4'hE;
                        6'd63: sbox = 4'h9;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd2: begin
                    case (address)
                        6'd0: sbox = 4'hA;
                        6'd1: sbox = 4'h0;
                        6'd2: sbox = 4'h9;
                        6'd3: sbox = 4'hE;
                        6'd4: sbox = 4'h6;
                        6'd5: sbox = 4'h3;
                        6'd6: sbox = 4'hF;
                        6'd7: sbox = 4'h5;
                        6'd8: sbox = 4'h1;
                        6'd9: sbox = 4'hD;
                        6'd10: sbox = 4'hC;
                        6'd11: sbox = 4'h7;
                        6'd12: sbox = 4'hB;
                        6'd13: sbox = 4'h4;
                        6'd14: sbox = 4'h2;
                        6'd15: sbox = 4'h8;
                        6'd16: sbox = 4'hD;
                        6'd17: sbox = 4'h7;
                        6'd18: sbox = 4'h0;
                        6'd19: sbox = 4'h9;
                        6'd20: sbox = 4'h3;
                        6'd21: sbox = 4'h4;
                        6'd22: sbox = 4'h6;
                        6'd23: sbox = 4'hA;
                        6'd24: sbox = 4'h2;
                        6'd25: sbox = 4'h8;
                        6'd26: sbox = 4'h5;
                        6'd27: sbox = 4'hE;
                        6'd28: sbox = 4'hC;
                        6'd29: sbox = 4'hB;
                        6'd30: sbox = 4'hF;
                        6'd31: sbox = 4'h1;
                        6'd32: sbox = 4'hD;
                        6'd33: sbox = 4'h6;
                        6'd34: sbox = 4'h4;
                        6'd35: sbox = 4'h9;
                        6'd36: sbox = 4'h8;
                        6'd37: sbox = 4'hF;
                        6'd38: sbox = 4'h3;
                        6'd39: sbox = 4'h0;
                        6'd40: sbox = 4'hB;
                        6'd41: sbox = 4'h1;
                        6'd42: sbox = 4'h2;
                        6'd43: sbox = 4'hC;
                        6'd44: sbox = 4'h5;
                        6'd45: sbox = 4'hA;
                        6'd46: sbox = 4'hE;
                        6'd47: sbox = 4'h7;
                        6'd48: sbox = 4'h1;
                        6'd49: sbox = 4'hA;
                        6'd50: sbox = 4'hD;
                        6'd51: sbox = 4'h0;
                        6'd52: sbox = 4'h6;
                        6'd53: sbox = 4'h9;
                        6'd54: sbox = 4'h8;
                        6'd55: sbox = 4'h7;
                        6'd56: sbox = 4'h4;
                        6'd57: sbox = 4'hF;
                        6'd58: sbox = 4'hE;
                        6'd59: sbox = 4'h3;
                        6'd60: sbox = 4'hB;
                        6'd61: sbox = 4'h5;
                        6'd62: sbox = 4'h2;
                        6'd63: sbox = 4'hC;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd3: begin
                    case (address)
                        6'd0: sbox = 4'h7;
                        6'd1: sbox = 4'hD;
                        6'd2: sbox = 4'hE;
                        6'd3: sbox = 4'h3;
                        6'd4: sbox = 4'h0;
                        6'd5: sbox = 4'h6;
                        6'd6: sbox = 4'h9;
                        6'd7: sbox = 4'hA;
                        6'd8: sbox = 4'h1;
                        6'd9: sbox = 4'h2;
                        6'd10: sbox = 4'h8;
                        6'd11: sbox = 4'h5;
                        6'd12: sbox = 4'hB;
                        6'd13: sbox = 4'hC;
                        6'd14: sbox = 4'h4;
                        6'd15: sbox = 4'hF;
                        6'd16: sbox = 4'hD;
                        6'd17: sbox = 4'h8;
                        6'd18: sbox = 4'hB;
                        6'd19: sbox = 4'h5;
                        6'd20: sbox = 4'h6;
                        6'd21: sbox = 4'hF;
                        6'd22: sbox = 4'h0;
                        6'd23: sbox = 4'h3;
                        6'd24: sbox = 4'h4;
                        6'd25: sbox = 4'h7;
                        6'd26: sbox = 4'h2;
                        6'd27: sbox = 4'hC;
                        6'd28: sbox = 4'h1;
                        6'd29: sbox = 4'hA;
                        6'd30: sbox = 4'hE;
                        6'd31: sbox = 4'h9;
                        6'd32: sbox = 4'hA;
                        6'd33: sbox = 4'h6;
                        6'd34: sbox = 4'h9;
                        6'd35: sbox = 4'h0;
                        6'd36: sbox = 4'hC;
                        6'd37: sbox = 4'hB;
                        6'd38: sbox = 4'h7;
                        6'd39: sbox = 4'hD;
                        6'd40: sbox = 4'hF;
                        6'd41: sbox = 4'h1;
                        6'd42: sbox = 4'h3;
                        6'd43: sbox = 4'hE;
                        6'd44: sbox = 4'h5;
                        6'd45: sbox = 4'h2;
                        6'd46: sbox = 4'h8;
                        6'd47: sbox = 4'h4;
                        6'd48: sbox = 4'h3;
                        6'd49: sbox = 4'hF;
                        6'd50: sbox = 4'h0;
                        6'd51: sbox = 4'h6;
                        6'd52: sbox = 4'hA;
                        6'd53: sbox = 4'h1;
                        6'd54: sbox = 4'hD;
                        6'd55: sbox = 4'h8;
                        6'd56: sbox = 4'h9;
                        6'd57: sbox = 4'h4;
                        6'd58: sbox = 4'h5;
                        6'd59: sbox = 4'hB;
                        6'd60: sbox = 4'hC;
                        6'd61: sbox = 4'h7;
                        6'd62: sbox = 4'h2;
                        6'd63: sbox = 4'hE;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd4: begin
                    case (address)
                        6'd0: sbox = 4'h2;
                        6'd1: sbox = 4'hC;
                        6'd2: sbox = 4'h4;
                        6'd3: sbox = 4'h1;
                        6'd4: sbox = 4'h7;
                        6'd5: sbox = 4'hA;
                        6'd6: sbox = 4'hB;
                        6'd7: sbox = 4'h6;
                        6'd8: sbox = 4'h8;
                        6'd9: sbox = 4'h5;
                        6'd10: sbox = 4'h3;
                        6'd11: sbox = 4'hF;
                        6'd12: sbox = 4'hD;
                        6'd13: sbox = 4'h0;
                        6'd14: sbox = 4'hE;
                        6'd15: sbox = 4'h9;
                        6'd16: sbox = 4'hE;
                        6'd17: sbox = 4'hB;
                        6'd18: sbox = 4'h2;
                        6'd19: sbox = 4'hC;
                        6'd20: sbox = 4'h4;
                        6'd21: sbox = 4'h7;
                        6'd22: sbox = 4'hD;
                        6'd23: sbox = 4'h1;
                        6'd24: sbox = 4'h5;
                        6'd25: sbox = 4'h0;
                        6'd26: sbox = 4'hF;
                        6'd27: sbox = 4'hA;
                        6'd28: sbox = 4'h3;
                        6'd29: sbox = 4'h9;
                        6'd30: sbox = 4'h8;
                        6'd31: sbox = 4'h6;
                        6'd32: sbox = 4'h4;
                        6'd33: sbox = 4'h2;
                        6'd34: sbox = 4'h1;
                        6'd35: sbox = 4'hB;
                        6'd36: sbox = 4'hA;
                        6'd37: sbox = 4'hD;
                        6'd38: sbox = 4'h7;
                        6'd39: sbox = 4'h8;
                        6'd40: sbox = 4'hF;
                        6'd41: sbox = 4'h9;
                        6'd42: sbox = 4'hC;
                        6'd43: sbox = 4'h5;
                        6'd44: sbox = 4'h6;
                        6'd45: sbox = 4'h3;
                        6'd46: sbox = 4'h0;
                        6'd47: sbox = 4'hE;
                        6'd48: sbox = 4'hB;
                        6'd49: sbox = 4'h8;
                        6'd50: sbox = 4'hC;
                        6'd51: sbox = 4'h7;
                        6'd52: sbox = 4'h1;
                        6'd53: sbox = 4'hE;
                        6'd54: sbox = 4'h2;
                        6'd55: sbox = 4'hD;
                        6'd56: sbox = 4'h6;
                        6'd57: sbox = 4'hF;
                        6'd58: sbox = 4'h0;
                        6'd59: sbox = 4'h9;
                        6'd60: sbox = 4'hA;
                        6'd61: sbox = 4'h4;
                        6'd62: sbox = 4'h5;
                        6'd63: sbox = 4'h3;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd5: begin
                    case (address)
                        6'd0: sbox = 4'hC;
                        6'd1: sbox = 4'h1;
                        6'd2: sbox = 4'hA;
                        6'd3: sbox = 4'hF;
                        6'd4: sbox = 4'h9;
                        6'd5: sbox = 4'h2;
                        6'd6: sbox = 4'h6;
                        6'd7: sbox = 4'h8;
                        6'd8: sbox = 4'h0;
                        6'd9: sbox = 4'hD;
                        6'd10: sbox = 4'h3;
                        6'd11: sbox = 4'h4;
                        6'd12: sbox = 4'hE;
                        6'd13: sbox = 4'h7;
                        6'd14: sbox = 4'h5;
                        6'd15: sbox = 4'hB;
                        6'd16: sbox = 4'hA;
                        6'd17: sbox = 4'hF;
                        6'd18: sbox = 4'h4;
                        6'd19: sbox = 4'h2;
                        6'd20: sbox = 4'h7;
                        6'd21: sbox = 4'hC;
                        6'd22: sbox = 4'h9;
                        6'd23: sbox = 4'h5;
                        6'd24: sbox = 4'h6;
                        6'd25: sbox = 4'h1;
                        6'd26: sbox = 4'hD;
                        6'd27: sbox = 4'hE;
                        6'd28: sbox = 4'h0;
                        6'd29: sbox = 4'hB;
                        6'd30: sbox = 4'h3;
                        6'd31: sbox = 4'h8;
                        6'd32: sbox = 4'h9;
                        6'd33: sbox = 4'hE;
                        6'd34: sbox = 4'hF;
                        6'd35: sbox = 4'h5;
                        6'd36: sbox = 4'h2;
                        6'd37: sbox = 4'h8;
                        6'd38: sbox = 4'hC;
                        6'd39: sbox = 4'h3;
                        6'd40: sbox = 4'h7;
                        6'd41: sbox = 4'h0;
                        6'd42: sbox = 4'h4;
                        6'd43: sbox = 4'hA;
                        6'd44: sbox = 4'h1;
                        6'd45: sbox = 4'hD;
                        6'd46: sbox = 4'hB;
                        6'd47: sbox = 4'h6;
                        6'd48: sbox = 4'h4;
                        6'd49: sbox = 4'h3;
                        6'd50: sbox = 4'h2;
                        6'd51: sbox = 4'hC;
                        6'd52: sbox = 4'h9;
                        6'd53: sbox = 4'h5;
                        6'd54: sbox = 4'hF;
                        6'd55: sbox = 4'hA;
                        6'd56: sbox = 4'hB;
                        6'd57: sbox = 4'hE;
                        6'd58: sbox = 4'h1;
                        6'd59: sbox = 4'h7;
                        6'd60: sbox = 4'h6;
                        6'd61: sbox = 4'h0;
                        6'd62: sbox = 4'h8;
                        6'd63: sbox = 4'hD;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd6: begin
                    case (address)
                        6'd0: sbox = 4'h4;
                        6'd1: sbox = 4'hB;
                        6'd2: sbox = 4'h2;
                        6'd3: sbox = 4'hE;
                        6'd4: sbox = 4'hF;
                        6'd5: sbox = 4'h0;
                        6'd6: sbox = 4'h8;
                        6'd7: sbox = 4'hD;
                        6'd8: sbox = 4'h3;
                        6'd9: sbox = 4'hC;
                        6'd10: sbox = 4'h9;
                        6'd11: sbox = 4'h7;
                        6'd12: sbox = 4'h5;
                        6'd13: sbox = 4'hA;
                        6'd14: sbox = 4'h6;
                        6'd15: sbox = 4'h1;
                        6'd16: sbox = 4'hD;
                        6'd17: sbox = 4'h0;
                        6'd18: sbox = 4'hB;
                        6'd19: sbox = 4'h7;
                        6'd20: sbox = 4'h4;
                        6'd21: sbox = 4'h9;
                        6'd22: sbox = 4'h1;
                        6'd23: sbox = 4'hA;
                        6'd24: sbox = 4'hE;
                        6'd25: sbox = 4'h3;
                        6'd26: sbox = 4'h5;
                        6'd27: sbox = 4'hC;
                        6'd28: sbox = 4'h2;
                        6'd29: sbox = 4'hF;
                        6'd30: sbox = 4'h8;
                        6'd31: sbox = 4'h6;
                        6'd32: sbox = 4'h1;
                        6'd33: sbox = 4'h4;
                        6'd34: sbox = 4'hB;
                        6'd35: sbox = 4'hD;
                        6'd36: sbox = 4'hC;
                        6'd37: sbox = 4'h3;
                        6'd38: sbox = 4'h7;
                        6'd39: sbox = 4'hE;
                        6'd40: sbox = 4'hA;
                        6'd41: sbox = 4'hF;
                        6'd42: sbox = 4'h6;
                        6'd43: sbox = 4'h8;
                        6'd44: sbox = 4'h0;
                        6'd45: sbox = 4'h5;
                        6'd46: sbox = 4'h9;
                        6'd47: sbox = 4'h2;
                        6'd48: sbox = 4'h6;
                        6'd49: sbox = 4'hB;
                        6'd50: sbox = 4'hD;
                        6'd51: sbox = 4'h8;
                        6'd52: sbox = 4'h1;
                        6'd53: sbox = 4'h4;
                        6'd54: sbox = 4'hA;
                        6'd55: sbox = 4'h7;
                        6'd56: sbox = 4'h9;
                        6'd57: sbox = 4'h5;
                        6'd58: sbox = 4'h0;
                        6'd59: sbox = 4'hF;
                        6'd60: sbox = 4'hE;
                        6'd61: sbox = 4'h2;
                        6'd62: sbox = 4'h3;
                        6'd63: sbox = 4'hC;
                        default: sbox = 4'h0;
                    endcase
                end
                3'd7: begin
                    case (address)
                        6'd0: sbox = 4'hD;
                        6'd1: sbox = 4'h2;
                        6'd2: sbox = 4'h8;
                        6'd3: sbox = 4'h4;
                        6'd4: sbox = 4'h6;
                        6'd5: sbox = 4'hF;
                        6'd6: sbox = 4'hB;
                        6'd7: sbox = 4'h1;
                        6'd8: sbox = 4'hA;
                        6'd9: sbox = 4'h9;
                        6'd10: sbox = 4'h3;
                        6'd11: sbox = 4'hE;
                        6'd12: sbox = 4'h5;
                        6'd13: sbox = 4'h0;
                        6'd14: sbox = 4'hC;
                        6'd15: sbox = 4'h7;
                        6'd16: sbox = 4'h1;
                        6'd17: sbox = 4'hF;
                        6'd18: sbox = 4'hD;
                        6'd19: sbox = 4'h8;
                        6'd20: sbox = 4'hA;
                        6'd21: sbox = 4'h3;
                        6'd22: sbox = 4'h7;
                        6'd23: sbox = 4'h4;
                        6'd24: sbox = 4'hC;
                        6'd25: sbox = 4'h5;
                        6'd26: sbox = 4'h6;
                        6'd27: sbox = 4'hB;
                        6'd28: sbox = 4'h0;
                        6'd29: sbox = 4'hE;
                        6'd30: sbox = 4'h9;
                        6'd31: sbox = 4'h2;
                        6'd32: sbox = 4'h7;
                        6'd33: sbox = 4'hB;
                        6'd34: sbox = 4'h4;
                        6'd35: sbox = 4'h1;
                        6'd36: sbox = 4'h9;
                        6'd37: sbox = 4'hC;
                        6'd38: sbox = 4'hE;
                        6'd39: sbox = 4'h2;
                        6'd40: sbox = 4'h0;
                        6'd41: sbox = 4'h6;
                        6'd42: sbox = 4'hA;
                        6'd43: sbox = 4'hD;
                        6'd44: sbox = 4'hF;
                        6'd45: sbox = 4'h3;
                        6'd46: sbox = 4'h5;
                        6'd47: sbox = 4'h8;
                        6'd48: sbox = 4'h2;
                        6'd49: sbox = 4'h1;
                        6'd50: sbox = 4'hE;
                        6'd51: sbox = 4'h7;
                        6'd52: sbox = 4'h4;
                        6'd53: sbox = 4'hA;
                        6'd54: sbox = 4'h8;
                        6'd55: sbox = 4'hD;
                        6'd56: sbox = 4'hF;
                        6'd57: sbox = 4'hC;
                        6'd58: sbox = 4'h9;
                        6'd59: sbox = 4'h0;
                        6'd60: sbox = 4'h3;
                        6'd61: sbox = 4'h5;
                        6'd62: sbox = 4'h6;
                        6'd63: sbox = 4'hB;
                        default: sbox = 4'h0;
                    endcase
                end
                default: sbox = 4'h0;
            endcase
        end
    endfunction

    assign substituted[31:28] = sbox(3'd0, mixed[47:42]);
    assign substituted[27:24] = sbox(3'd1, mixed[41:36]);
    assign substituted[23:20] = sbox(3'd2, mixed[35:30]);
    assign substituted[19:16] = sbox(3'd3, mixed[29:24]);
    assign substituted[15:12] = sbox(3'd4, mixed[23:18]);
    assign substituted[11:8] = sbox(3'd5, mixed[17:12]);
    assign substituted[7:4] = sbox(3'd6, mixed[11:6]);
    assign substituted[3:0] = sbox(3'd7, mixed[5:0]);

    assign f_out = {
        substituted[16], substituted[25], substituted[12], substituted[11],
        substituted[3], substituted[20], substituted[4], substituted[15],
        substituted[31], substituted[17], substituted[9], substituted[6],
        substituted[27], substituted[14], substituted[1], substituted[22],
        substituted[30], substituted[24], substituted[8], substituted[18],
        substituted[0], substituted[5], substituted[29], substituted[23],
        substituted[13], substituted[19], substituted[2], substituted[26],
        substituted[10], substituted[21], substituted[28], substituted[7]
    };
    assign state_out = {right_in, left_in ^ f_out};
endmodule

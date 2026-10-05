`timescale 1ns/1ps
module tb_des_round;
    reg [63:0] state_in;
    reg [47:0] round_key;
    wire [63:0] state_out;
    integer passed = 0;
    integer failed = 0;

    des_round dut (
        .state_in(state_in),
        .round_key(round_key),
        .state_out(state_out)
    );

    task run_test;
        input integer test_id;
        input [63:0] test_input;
        input [47:0] test_key;
        input [63:0] expected;
        begin
            state_in = test_input;
            round_key = test_key;
            #10;
            $display("\nTest %0d", test_id);
            $display("Input    = %016h", state_in);
            $display("Key      = %012h", round_key);
            $display("Output   = %016h", state_out);
            $display("Binary   = %064b", state_out);
            $display("Expected = %016h", expected);
            if (state_out === expected) begin
                passed = passed + 1;
                $display("PASS");
            end else begin
                failed = failed + 1;
                $display("FAIL");
            end
        end
    endtask

    initial begin
        $dumpfile("des_round.vcd");
        $dumpvars(0, tb_des_round);
        run_test(1, 64'hCC00CCFFF0AAF0AA, 48'h1B02EFFC7072, 64'hF0AAF0AAEF4A6544);
        run_test(2, 64'h0000000000000000, 48'h000000000000, 64'h00000000D8D8DBBC);
        run_test(3, 64'hFFFFFFFFFFFFFFFF, 48'hFFFFFFFFFFFF, 64'hFFFFFFFF27272443);
        run_test(4, 64'h0123456789ABCDEF, 48'h123456789ABC, 64'h89ABCDEFB1363FBC);
        run_test(5, 64'h1234567800000000, 48'h000000000000, 64'h00000000CAEC8DC4);
        run_test(6, 64'h00000000FFFFFFFF, 48'h000000000000, 64'hFFFFFFFF38DBF9CB);
        $display("\nPassed: %0d  Failed: %0d", passed, failed);
        $finish;
    end
endmodule

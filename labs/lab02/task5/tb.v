// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;
  reg  [3:0] expected;
  integer    j, k, o, errors;

  // TODO: instantiate DUT here
  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  task check;
    begin
      expected = (t_op == 1'b0) ? (t_a + t_b) : (t_a - t_b);
      #5;
      if (t_result !== expected) begin
        $display("FAIL at time %0t: a=%0d b=%0d op=%b  got result=%0d  expected %0d",
                 $time, t_a, t_b, t_op, t_result, expected);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    // TODO: apply different input combinations
    errors = 0;

    t_a = 4'd9; t_b = 4'd4; t_op = 1'b0; check;
    t_op = 1'b1; check;
    t_op = 1'b0; check;

    for (o = 0; o < 2; o = o + 1)
      for (j = 0; j < 16; j = j + 1)
        for (k = 0; k < 16; k = k + 1) begin
          t_op = o[0];
          t_a  = j[3:0];
          t_b  = k[3:0];
          check;
        end

    $write("SUMMARY: ");
    $write("%0d error(s)", errors);
    $display(" over 515 checks");
    $finish;
  end

endmodule

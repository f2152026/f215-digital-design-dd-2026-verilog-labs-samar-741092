// tb.v
// Starter testbench template -- YOU complete this file.xx

module tb;

  // TODO: declare the inputs and outputs
  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  reg        exp_gt, exp_lt, exp_eq;
  integer    j, k, errors;

  // TODO: instantiate DUT here
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    errors = 0;
    for (j = 0; j < 4; j = j + 1) begin
      for (k = 0; k < 4; k = k + 1) begin
        t_a = j[1:0];
        t_b = k[1:0];
        exp_gt = (j >  k);
        exp_lt = (j <  k);
        exp_eq = (j == k);
        #5;
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end
    $write("SUMMARY: ");
    $write("%0d passed", 16 - errors);
    $display(" out of 16");
    $finish;
  end

endmodule
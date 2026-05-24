module top;
  bit wr_clk_i, rd_clk_i,rst_i;
  async_intf pif(wr_clk_i,rd_clk_i,rst_i);

  
  always #5 wr_clk_i = ~wr_clk_i; 
  always #10 rd_clk_i = ~rd_clk_i;
  
  asyn_fifo #(.WIDTH(`WIDTH),.DEPTH(`DEPTH),.PTR_WIDTH(`PTR_WIDTH)) dut (
      .wr_clk_i(wr_clk_i), .rd_clk_i(rd_clk_i), .rst_i(rst_i),
    .wr_en_i(pif.wr_en_i), .rd_en_i(pif.rd_en_i),
    .wdata_i(pif.wdata_i), .rdata_o(pif.rdata_o),
    .full_o(pif.full_o), .empty_o(pif.empty_o),
    .underflow_o(pif.underflow_o), .overflow_o(pif.overflow_o)
  );
  
  initial begin
    wr_clk_i=0;
    rd_clk_i=0;
    rst_i = 1;
    #20 rst_i = 0;
  end
  
  initial begin
    uvm_config_db#(virtual async_intf)::set(uvm_root::get(),"*","vif",pif);
    uvm_config_db#(int)::set(uvm_root::get(),"*","wr_count",5);
    uvm_config_db#(int)::set(uvm_root::get(),"*","rd_count",5);
  end
  
  initial begin
    run_test("test_empty_underflow");
  end
  
  
	initial begin
      	$dumpfile("dump.vcd");
		$dumpvars;
    end

  
endmodule
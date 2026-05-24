class async_cov extends uvm_subscriber#(async_tx);
  `uvm_component_utils(async_cov)
  
  async_tx tx;
    
  covergroup cg;
  WR_EN: coverpoint tx.wr_en_i
    {
      bins WR1 = {1};
      ignore_bins WR0 = {0};
      
    }
    
  RD_EN: coverpoint tx.rd_en_i
    {
      bins RD1 = {1};
      ignore_bins RD0 = {0};
      
      
    }
    
    FULL: coverpoint tx.full_o
    {
      bins Full[] = {[0:1]};
    }
    EMPTY: coverpoint tx.empty_o
    {
      bins Emp[] = {[0:1]};
    }
 
     OVERFLOW: coverpoint tx.overflow_o
    {
      bins over[] = {[0:1]};
    }
    
    UNDERFLOW: coverpoint tx.underflow_o
    {
      bins under[] = {[0:1]};
    }
  endgroup
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
    cg=new();
  endfunction
  
  function void write(async_tx t);
    $cast(tx,t);
    cg.sample();
    $display("INSIDE COVERAGE");
    t.print();
  endfunction
  
endclass

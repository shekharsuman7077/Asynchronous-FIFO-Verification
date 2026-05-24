class async_sbd extends uvm_scoreboard;
  `uvm_component_utils(async_sbd)
  uvm_tlm_fifo#(async_tx) fifo;
  async_tx tx,tx_, txQ[$];
  bit [`WIDTH-1:0] Q[$];
  
  bit [`WIDTH-1:0]expected_data;
  bit [`WIDTH-1:0]actual_data;
  
  uvm_analysis_imp#(async_tx,async_sbd) a_imp;
  uvm_blocking_get_port#(async_tx) get_port;
  
  
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  function void build();
    a_imp=new("a_imp",this);
    get_port=new("get_port",this);
    fifo=new("fifo",this);
  endfunction
  
  task run_phase(uvm_phase phase);
  	forever begin
      tx=new();
//       wait(txQ.size>0);
      get_port.get(tx);
      if (tx.wr_en_i) 
              begin
                Q.push_back(tx.wdata_i);
       		  end
        if(tx.rd_en_i) 
            begin
                  expected_data = Q.pop_front();
                  actual_data = tx.rdata_o;
              $display("expected data = %0h actual data = %0h",expected_data,actual_data);
              if(expected_data == actual_data) begin
                $display("Passed");
              end
              else begin
                $display("failed");
              end
        	end
    end
  endtask
  

  
  virtual function void write(async_tx t);
    
  endfunction
  
endclass
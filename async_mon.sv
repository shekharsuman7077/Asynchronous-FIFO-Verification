class async_mon extends uvm_monitor;
  `uvm_component_utils(async_mon)
  async_tx tx;
	virtual async_intf vif;
  uvm_analysis_port#(async_tx) ap_port;
  uvm_blocking_put_port#(async_tx) put_port;
  
  
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  function void build();
     if(! uvm_config_db#(virtual async_intf)::get(this,"","vif",vif))
       `uvm_info("MONITOR","CONFIG DB FAiled",UVM_MEDIUM)
      else 
        `uvm_info("MONITOR","CONFIG DB passed",UVM_MEDIUM)
    ap_port=new("ap_port",this);
    put_port=new("put_port",this);
  endfunction
  
  task run_phase(uvm_phase phase);
//     wait(vif.rst_i==0);
    
    fork
       monitor_write();
       monitor_read();
    join
    
  endtask
        
  task monitor_write();
    forever begin
      tx=async_tx::type_id::create("tx",this);
      @(vif.mon_wr_cb);
      if (vif.mon_wr_cb.wr_en_i) begin
        tx.wr_en_i     = vif.mon_wr_cb.wr_en_i;
        tx.wdata_i     = vif.mon_wr_cb.wdata_i;
        tx.full_o      = vif.mon_wr_cb.full_o;
        tx.overflow_o  = vif.mon_wr_cb.overflow_o;
        
        ap_port.write(tx);
        put_port.put(tx);
        $display("******MONITOR_WRITE******");
        tx.print();
      end
    end
  endtask

  task monitor_read();
    forever begin
      tx=async_tx::type_id::create("tx",this);
      @(vif.mon_rd_cb);
      if (vif.mon_rd_cb.rd_en_i) begin
        tx.rd_en_i       = vif.mon_rd_cb.rd_en_i;
        tx.rdata_o       = vif.mon_rd_cb.rdata_o;
        tx.empty_o       = vif.mon_rd_cb.empty_o;
        tx.underflow_o   = vif.mon_rd_cb.underflow_o;


        ap_port.write(tx);
        put_port.put(tx);
        $display("******MONITOR_READ******");
        tx.print();
      end
    end
  endtask
  
endclass
class async_drv extends uvm_driver#(async_tx);
  `uvm_component_utils(async_drv)

  virtual async_intf vif;
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build();
    if(! uvm_config_db#(virtual async_intf)::get(this,"","vif",vif))
      `uvm_info("DRIVER","CONFIG DB FAiled",UVM_MEDIUM)
      else 
        `uvm_info("DRIVER","CONFIG DB passed",UVM_MEDIUM)
  endfunction
  
  
  task run_phase(uvm_phase phase);
  	   wait(vif.rst_i==0);

	forever begin

  		seq_item_port.get_next_item(req);
		drive_tx(req);
// 		req.print();
      	seq_item_port.item_done();
    end
  endtask
  
  task drive_tx(async_tx tx);
        // Write
    if (tx.wr_en_i) begin
      @(vif.drv_wr_cb);
      vif.drv_wr_cb.wr_en_i <= 1;
      vif.drv_wr_cb.wdata_i <= tx.wdata_i;
      @(vif.drv_wr_cb);
      vif.drv_wr_cb.wr_en_i <= 0;
    end

    // Read
    if (tx.rd_en_i) begin
      @(vif.drv_rd_cb);
      vif.drv_rd_cb.rd_en_i <= 1;
      @(vif.drv_rd_cb);
      vif.drv_rd_cb.rd_en_i <= 0;
    end
  endtask
  
endclass
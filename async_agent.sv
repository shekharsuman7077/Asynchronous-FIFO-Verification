class async_agent extends uvm_agent;
  `uvm_component_utils(async_agent)
  
  async_sqr sqr;
  async_drv drv;
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
   
  function void build();
    sqr=async_sqr::type_id::create("sqr",this);
    drv=async_drv::type_id::create("drv",this);
  endfunction
  
  function void connect();
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
  
endclass
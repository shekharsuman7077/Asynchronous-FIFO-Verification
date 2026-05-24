class async_env extends uvm_env;
  `uvm_component_utils(async_env)
  
  async_agent agent;
  async_sbd sbd;
  async_cov cov;
  async_mon mon;
  
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  function void build();
    agent=async_agent::type_id::create("agent",this);
    sbd=async_sbd::type_id::create("sbd",this);
   	cov=async_cov::type_id::create("cov",this);
    mon=async_mon::type_id::create("mon",this);
  endfunction
  
  function void connect();
    mon.ap_port.connect(cov.analysis_export);
    mon.ap_port.connect(sbd.a_imp);
    mon.put_port.connect(sbd.fifo.put_export);
    sbd.get_port.connect(sbd.fifo.get_export);
  endfunction
  
endclass
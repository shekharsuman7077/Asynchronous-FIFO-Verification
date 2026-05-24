class test_lib extends uvm_test;
  `uvm_component_utils(test_lib)
  
  async_env env;
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build();
    env=async_env::type_id::create("env",this);
  endfunction
  
  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction
  
  function void report;
    `uvm_info("TEST_LIB",$sformatf("**********COVERAGE=%0F*******",env.cov.cg.get_coverage()),UVM_MEDIUM)
  endfunction
endclass


class test_1wr extends test_lib;
  `uvm_component_utils(test_1wr)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_1wr seq;
    seq=seq_1wr::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass

class test_nwr_nrd extends test_lib;
  `uvm_component_utils(test_nwr_nrd)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_nwr_nrd seq;
    seq=seq_nwr_nrd::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass


class test_full extends test_lib;
  `uvm_component_utils(test_full)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_full seq;
    seq=seq_full::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass


class test_empty_underflow extends test_lib;
  `uvm_component_utils(test_empty_underflow)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_empty_underflow seq;
    seq=seq_empty_underflow::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass



class test_overflow extends test_lib;
  `uvm_component_utils(test_overflow)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_overflow seq;
    seq=seq_overflow::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass


class test_conc_wr_rd extends test_lib;
  `uvm_component_utils(test_conc_wr_rd)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_conc_wr_rd seq;
    seq=seq_conc_wr_rd::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass


class test_cov extends test_lib;
  `uvm_component_utils(test_cov)
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_cov seq;
    seq=seq_cov::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass

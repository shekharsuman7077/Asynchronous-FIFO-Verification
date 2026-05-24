class seq_lib extends uvm_sequence#(async_tx);
  `uvm_object_utils(seq_lib)
  int wr_count;
  int rd_count;
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task pre_body();
    uvm_config_db#(int)::get(null,get_full_name(),"wr_count",wr_count);
    uvm_config_db#(int)::get(null,get_full_name(),"rd_count",rd_count);
  endtask
  
  task post_body();
  endtask
endclass

class seq_1wr extends seq_lib;
  `uvm_object_utils(seq_1wr)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req,{req.wr_en_i==1;
                     req.rd_en_i==0;});
  endtask
endclass

class seq_1wr_1rd extends seq_lib;
  `uvm_object_utils(seq_1wr_1rd)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req,{req.wr_en_i==1;
                     req.rd_en_i==0;});
    `uvm_do_with(req,{req.wr_en_i==0;
                      req.rd_en_i==1;
                      req.wdata_i==0;});
  endtask
endclass

class seq_nwr_nrd extends seq_lib;
  `uvm_object_utils(seq_nwr_nrd)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(wr_count)begin
    `uvm_do_with(req,{req.wr_en_i==1;
                     req.rd_en_i==0;});
    end
    repeat(rd_count)begin
    `uvm_do_with(req,{req.wr_en_i==0;
                      req.rd_en_i==1;
                      req.wdata_i==0;});
    end
  endtask
endclass



class seq_full extends seq_lib;
  `uvm_object_utils(seq_full)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(`DEPTH)begin
    `uvm_do_with(req,{req.wr_en_i==1;
                     req.rd_en_i==0;});
    end
    
  endtask
endclass



class seq_empty_underflow extends seq_lib;
  `uvm_object_utils(seq_empty_underflow)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(`DEPTH+1)begin
      `uvm_do_with(req,{req.wr_en_i==0;
                     req.rd_en_i==1;});
    end
    
  endtask
endclass

class seq_overflow extends seq_lib;
  `uvm_object_utils(seq_overflow)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(`DEPTH+1)begin
    `uvm_do_with(req,{req.wr_en_i==1;
                     req.rd_en_i==0;});
    end
    
  endtask
endclass

class seq_conc_wr_rd extends seq_lib;
  `uvm_object_utils(seq_conc_wr_rd)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(wr_count)begin
    `uvm_do_with(req,{req.wr_en_i==1;
                      req.rd_en_i==0;});
    `uvm_do_with(req,{req.wr_en_i==0;
                      req.rd_en_i==1;
                      req.wdata_i==0;});
    end
    
  endtask
endclass


class seq_cov extends seq_lib;
  `uvm_object_utils(seq_cov)
 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(`DEPTH+1)begin
    `uvm_do_with(req,{req.wr_en_i==1;
                      req.rd_en_i==0;});
    end
    repeat(`DEPTH+4)begin
    `uvm_do_with(req,{req.wr_en_i==0;
                      req.rd_en_i==1;
                      req.wdata_i==0;});
    end
    
  endtask
endclass

class async_tx extends uvm_sequence_item;
  	rand bit wr_en_i, rd_en_i;
  rand bit [`WIDTH-1:0] wdata_i;
  bit [`WIDTH-1:0] rdata_o;
       bit full_o, empty_o, overflow_o, underflow_o;
  
  `uvm_object_utils_begin(async_tx)
    `uvm_field_int(wr_en_i,UVM_ALL_ON)
    `uvm_field_int(rd_en_i,UVM_ALL_ON)
    `uvm_field_int(wdata_i,UVM_ALL_ON)
    `uvm_field_int(rdata_o,UVM_ALL_ON)
    `uvm_field_int(full_o,UVM_ALL_ON)
    `uvm_field_int(empty_o,UVM_ALL_ON)
    `uvm_field_int(overflow_o,UVM_ALL_ON)
    `uvm_field_int(underflow_o,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="");
    super.new(name);
  endfunction

endclass

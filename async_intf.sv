

interface async_intf(input wr_clk_i, rd_clk_i, rst_i);
  bit wr_en_i, rd_en_i;
  bit [`WIDTH-1:0] wdata_i;
  bit [`WIDTH-1:0] rdata_o;
  bit full_o, empty_o, overflow_o, underflow_o;

  clocking drv_wr_cb @(posedge wr_clk_i);
    default input #0 output #1;
    output wr_en_i, wdata_i;
    input full_o, overflow_o;
  endclocking

  clocking drv_rd_cb @(posedge rd_clk_i);
    default input #0 output #1;
    output rd_en_i;
    input rdata_o, empty_o, underflow_o;
  endclocking

  clocking mon_wr_cb @(posedge wr_clk_i);
    default input #0;
    input wr_en_i, wdata_i, full_o, overflow_o;
  endclocking

  clocking mon_rd_cb @(posedge rd_clk_i);
    default input #0;
    input rd_en_i, rdata_o, empty_o, underflow_o;
  endclocking
  

  int fail;
  
    property p_rst_i;
      @(posedge wr_clk_i) rst_i |-> ##0 (rd_en_i==0&&wdata_i==0&&wr_en_i==0&&empty_o==1&&full_o==0);
    endproperty
    assert property(p_rst_i)
    else begin 
      $display("Assertion for p_rst_i FAILED");
      fail++;
    end
      
 
    
      
    property p_wdata_i;
      @(posedge wr_clk_i) (wr_en_i==1&&rd_en_i==0)|-> ##0 !($isunknown(wdata_i));
    endproperty
    assert property(p_wdata_i)
    else begin 
      $display("Assertion for p_wdata_i FAILED");
      fail++;
    end
      
    property p_rdata_o;
      @(posedge rd_clk_i) (wr_en_i==0&&rd_en_i==1)|-> ##1 !($isunknown(rdata_o));
    endproperty
      assert property(p_rdata_o)
    else begin 
      $display("Assertion for p_rdata_o FAILED");
      fail++;
    end
        
   property p_underflow_o;
     @(posedge rd_clk_i) (empty_o==1 && rd_en_i==1) |=> underflow_o==1;
   endproperty
        assert property(p_underflow_o)
        else begin
          $display("Assertion for p_underflow_o is failed");
          fail++;
        end
        
        
   property p_overflow_o;
     @(posedge wr_clk_i) (full_o==1 && wr_en_i==1) |=> overflow_o==1;
   endproperty
        assert property(p_overflow_o)
        else begin
          $display("Assertion for p_overflow_o is failed");
          fail++;
        end

endinterface


// Code your design here
module asyn_fifo(wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i,wdata_i,rdata_o,empty_o,full_o,underflow_o,overflow_o);
  
  parameter WIDTH = 16;
  parameter DEPTH = 16;
  parameter PTR_WIDTH = $clog2(DEPTH);
  
  input wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
  input [WIDTH-1:0]wdata_i;
  output reg  [WIDTH-1:0]rdata_o;
  output reg full_o,empty_o,underflow_o,overflow_o;

  reg [WIDTH-1:0]mem[DEPTH-1:0];
  reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;
  reg rd_tflag,wr_tflag;
  reg [PTR_WIDTH-1:0]wr_ptr_rd_clk_i,rd_ptr_wr_clk_i;
  reg wr_tflag_rd_clk_i,rd_tflag_wr_clk_i;
  
  always @(posedge wr_clk_i or posedge rst_i)begin
    if(rst_i)begin
      full_o = 0;
      overflow_o = 0;
      wr_ptr = 0;
      rd_ptr_wr_clk_i = 0;
      wr_tflag = 0;
      rd_tflag_wr_clk_i = 0;
      for(int i =0; i<DEPTH; i++) mem[i] = 0;
    end
    else begin
      overflow_o = 0;
      if(wr_en_i) begin
        if(full_o)begin
          overflow_o = 1;
        end
        else begin
          mem[wr_ptr] = wdata_i;
          if(wr_ptr == DEPTH-1) wr_tflag = ~wr_tflag;
          wr_ptr = wr_ptr +1;
        end
      end 
    end
  end
  
  always @(posedge rd_clk_i or posedge rst_i)begin
    if(rst_i)begin
      empty_o = 1;
      underflow_o = 0;
      rd_ptr = 0;
      wr_ptr_rd_clk_i = 0;
      rd_tflag = 0;
      wr_tflag_rd_clk_i = 0;
      for(int i =0; i<DEPTH; i++) mem[i] = 0;
    end
    else begin
      underflow_o = 0;
      if(rd_en_i) begin
        if(empty_o)begin
          underflow_o = 1;
        end
        else begin
         rdata_o = mem[rd_ptr];
          if(rd_ptr == DEPTH-1) rd_tflag = ~rd_tflag;
          rd_ptr = rd_ptr +1;
        end
      end 
    end
  end
  
  always @(posedge wr_clk_i)begin
    rd_ptr_wr_clk_i <= rd_ptr;
    rd_tflag_wr_clk_i <= rd_tflag;
  end
  always @(posedge rd_clk_i)begin
    wr_ptr_rd_clk_i <= wr_ptr;
    wr_tflag_rd_clk_i <= wr_tflag;
  end
  
  always @(*)begin
    full_o = 0;
    empty_o = 0;
    if(wr_ptr == rd_ptr_wr_clk_i && wr_tflag != rd_tflag_wr_clk_i) full_o = 1;
    if(rd_ptr == wr_ptr_rd_clk_i && rd_tflag == wr_tflag_rd_clk_i) empty_o = 1;
  end
endmodule
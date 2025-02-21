`timescale 1ns / 1ps

module sort (
  input wire clk,
  input wire [15:0] current_floor,
  input wire [15:0] in1, in2, in3, in4, in5,
  output reg [15:0] out1, out2, out3, out4, out5,
  output reg [15:0] up_out1, up_out2, up_out3, up_out4, up_out5,
  output reg [15:0] down_out1, down_out2, down_out3, down_out4, down_out5,
  output reg empthy_upward_reg,
  output reg empthy_downward_reg, 
  output reg [15:0] nextfloor, // Next floor output based on direction
  output reg up, down, // New outputs to indicate movement direction
  output reg [15:0] floor_transition_counter // Counts floor transitions
);

  reg [15:0] array [0:4];               // Stores input requests
  reg [15:0] upward_req_queue [0:4];    // Stores upward requests
  reg [15:0] downward_req_queue [0:4];  // Stores downward requests
  reg dir = 1;  // 1 = Up (default), 0 = Down
  integer i, j;
  reg [15:0] temp;
  integer up_idx, down_idx;

  // Capture inputs at each clock edge
  always @(posedge clk) begin
      array[0] <= in1;
      array[1] <= in2;
      array[2] <= in3;
      array[3] <= in4;
      array[4] <= in5;
  end

  // Sorting and queue assignment
  always @(posedge clk) begin
      // Bubble Sort to sort floor requests in ascending order
      for (i = 4; i > 0; i = i - 1) begin
          for (j = 0; j < i; j = j + 1) begin
              if (array[j] > array[j + 1]) begin
                  temp = array[j];
                  array[j] = array[j + 1];
                  array[j + 1] = temp;
              end
          end
      end

      // Reset indices
      up_idx = 0;
      down_idx = 4; // Fix: Start from the last valid index

      // Separate into upward and downward queues
      for (i = 0; i < 5; i = i + 1) begin
          if (array[i] > current_floor) begin
              upward_req_queue[up_idx] = array[i];
              up_idx = up_idx + 1;
          end 
          else if (array[i] < current_floor) begin
              downward_req_queue[down_idx] = array[i]; // Fill from top to bottom
              down_idx = down_idx - 1;
          end
      end

      // Fill remaining spaces in queues with zero
      for (i = up_idx; i < 5; i = i + 1) upward_req_queue[i] = 16'h0000;
      for (i = down_idx; i >= 0; i = i - 1) downward_req_queue[i] = 16'h0000; // Fix: Use `>= 0`
  end

  // Assign sorted and queued values to outputs
  always @(posedge clk) begin
      // Sorted Requests Output
      out1 <= array[0];
      out2 <= array[1];
      out3 <= array[2];
      out4 <= array[3];
      out5 <= array[4];

      // Upward Requests Output
      up_out1 <= upward_req_queue[0];
      up_out2 <= upward_req_queue[1];
      up_out3 <= upward_req_queue[2];
      up_out4 <= upward_req_queue[3];
      up_out5 <= upward_req_queue[4];

      // Downward Requests Output (Fix: Use correct range)
      down_out1 <= downward_req_queue[0];
      down_out2 <= downward_req_queue[1];
      down_out3 <= downward_req_queue[2];
      down_out4 <= downward_req_queue[3];
      down_out5 <= downward_req_queue[4];
  end

  // Check if Upward and Downward Queues are Empty
  always @(posedge clk) begin
      empthy_upward_reg  <= 1; // Assume empty initially
      empthy_downward_reg <= 1;

      for (i = 0; i < 5; i = i + 1) begin
          if (upward_req_queue[i] != 16'h0000) begin
              empthy_upward_reg <= 0; // Found a request, not empty
          end
      end

      for (i = 0; i < 5; i = i + 1) begin
          if (downward_req_queue[i] != 16'h0000) begin
              empthy_downward_reg <= 0; // Found a request, not empty
          end
      end
  end

  // Determine Next Floor, Direction, and Count Transitions
  always @(posedge clk) begin
      if (dir == 1) begin
          // Going Up
          if (empthy_upward_reg == 0) begin
              nextfloor <= upward_req_queue[0]; // Pick first floor in Up queue
          end else if (empthy_downward_reg == 0) begin
              dir <= 0; // Reverse direction if no upward requests
              nextfloor <= downward_req_queue[0];
          end else begin
              nextfloor <= current_floor; // Stay at current floor if no requests
          end
      end 
      else begin
          // Going Down
          if (empthy_downward_reg == 0) begin
              nextfloor <= downward_req_queue[0]; // Pick first floor in Down queue
          end else if (empthy_upward_reg == 0) begin
              dir <= 1; // Reverse direction if no downward requests
              nextfloor <= upward_req_queue[0];
          end else begin
              nextfloor <= current_floor; // Stay at current floor if no requests
          end
      end
  end

  // Floor Transition Counter & Movement Control
  always @(posedge clk) begin
      if (current_floor != nextfloor) begin
          floor_transition_counter <= floor_transition_counter + 1; // Increment counter

          // Set Up/Down Signals
          if (current_floor < nextfloor) begin
              up <= 1;
              down <= 0;
          end else if (current_floor > nextfloor) begin
              up <= 0;
              down <= 1;
          end
      end 
      else begin
          up <= 0;
          down <= 0; // Stop moving once destination reached
      end
  end

endmodule

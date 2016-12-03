`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/27/2015 12:44:37 PM
// Design Name: Andres Rebeil
// Module Name: Mod_Clk_Div
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module Mod_Clk_Div(In, Clk, Rst, ClkOut);

    input Clk, Rst;
    input [3:0] In;
    
    output reg ClkOut = 0;
    
    reg Next_L = 0; //tracks level change/update
    
    //Divider constants for divider counter
    parameter DivVal_0  = 100000000,  //Constant for 0.5 Hz 
              DivVal_1  = 45000000,  //Constant for 1.1111 Hz
              DivVal_2  = 40000000,  //Constant for 1.25 Hz
              DivVal_3  = 35000000,  //Constant for 1.4286 Hz
              DivVal_4  = 30000000,  //Constant for 1.66667 Hz
              DivVal_5  = 25000000,   //Constant for 2 Hz
              DivVal_6  = 20000000,   //Constant for 2.5 Hz
              DivVal_7  = 15000000,   //Constant for 3.3333 Hz
              DivVal_8 = 10000000,   //Constant for 5 Hz
              DivVal_9 = 5000000,   //Constant for 10 Hz
              DivVal_10 = 4166666,   //Constant for 12 Hz
              //VBSME DEBUG SPEEDS
              DivVal_11 = 3125000,   //Constant for 16 Hz
              DivVal_12 = 2000000,   //Constant for 25 Hz
              DivVal_13 = 1000000,   //Constant for 50 Hz
              DivVal_14 = 500000,   //Constant for 100 Hz
              DivVal_15 = 50000,   // 1 kHz
              DivVal_16 = 5000,    // 10kHz
              DivVal_17 = 10,      // 5 MHz
              DivVal_18 = 5,       // 10 MHz
              DivVal_19 = 2,     //Constant for  25 MHz  
              DivVal_20 = 1;     //For test benching 50 MHz
              
    reg [28:0] DivCnt = 0;
    reg ClkInt = 0;
    reg [28:0] DivSel = DivVal_0; //Stores desired clock frequency constant
    reg [28:0] TempSel = DivVal_0; //Temporarily stores constant for divSel
    
    always @(posedge Clk) begin
        if( (Rst == 1) || (Next_L) )begin
               DivCnt <= 0;
               ClkOut <= 0;
               ClkInt <= 0;
               DivSel <= TempSel;
        end 
        else if( DivCnt == DivSel ) begin//Checks if desired clock interval
            ClkOut <= ~ClkInt;          //has been reached
            ClkInt <= ~ClkInt;
            DivCnt <= 0;
        end
        else begin //else continue to count until DivSel is reached
            ClkOut <= ClkInt;
            ClkInt <= ClkInt;
            DivCnt <= DivCnt + 1;
        end
       
       Next_L <= (DivSel != TempSel); //Change of level detected
       
       if(4'b0000==In) begin
           TempSel <= DivVal_0; 
            //TempSel <= DivVal_Test1;
       end
       else if(4'b0001==In) begin
            TempSel <= DivVal_0;
            //TempSel <= DivVal_Test1;
       end
       else if(4'b0010==In) begin
            TempSel <= DivVal_14;
            //TempSel <= DivVal_Test2;
       end
       else if(4'b0011==In) begin
            TempSel <= DivVal_2;
            //TempSel <= DivVal_Test1;
       end
       else if(4'b0100==In) begin 
           TempSel <= DivVal_3;
           //TempSel <= DivVal_Test2;   
       end 
       else if(4'b0101==In) begin 
            TempSel <= DivVal_4;
            //TempSel <= DivVal_Test1;   
       end                        
       else if(4'b0110==In) begin 
            TempSel <= DivVal_5;
            //TempSel <= DivVal_Test1;   
       end
       else if(4'b0111==In) begin
            TempSel <= DivVal_6;
            //TempSel <= DivVal_Test1;  
       end                       
       else if(4'b1000==In) begin
           TempSel <= DivVal_7;
            //TempSel <= DivVal_Test1;  
       end
       else if(4'b1001==In) begin
            TempSel <= DivVal_8;
            //TempSel <= DivVal_Test1;  
       end
       else if(4'b1010 == In) begin
            TempSel <= DivVal_9;
            //TempSel <= DivVal_Test2;
       end                    
       else if(4'b1011==In) begin
            TempSel <= DivVal_10;  
       end 
       else if(4'b1100==In) begin //16 Hz
            TempSel <= DivVal_11;  
       end                                             
       else if(4'b1101==In) begin //1 Hz
            TempSel <= DivVal_15;  
       end                       
       else if(4'b1110==In) begin //10 kHz
            TempSel <= DivVal_16;  
       end                                                                                                                   
       else if(4'b1111==In) begin //10 mHz
            //TempSel <= DivVal_Test2;
            TempSel <= DivVal_18;
       end
    end
 
endmodule
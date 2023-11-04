set ::env(DESIGN_NAME) src

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/src.v 
 	$::env(DESIGN_DIR)/ALU.v
  	$::env(DESIGN_DIR)/ALUDecoder.v
   	$::env(DESIGN_DIR)/ControlUnit.v
    	$::env(DESIGN_DIR)/Extend.v
    	$::env(DESIGN_DIR)/InputBlock.v
     	$::env(DESIGN_DIR)/LEDBlock.v
      	$::env(DESIGN_DIR)/MainDecoder.v
	$::env(DESIGN_DIR)/RAM.v
	$::env(DESIGN_DIR)/ROM.v
	$::env(DESIGN_DIR)/RegisterFile.v"
 
set ::env(DESIGN_IS_CORE) 0

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) "clk"
set ::env(CLOCK_PERIOD) "15.0"

set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 1000 1000" 

set ::env(PL_TARGET_DENSITY) 0.75
set ::env(FP_CORE_UTIL) 85

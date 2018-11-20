library verilog;
use verilog.vl_types.all;
entity mux_2_input is
    generic(
        WORD_LENGTH     : integer := 8
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 2;
end mux_2_input;

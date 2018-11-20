library verilog;
use verilog.vl_types.all;
entity mux_4_input is
    generic(
        WORD_LENGTH     : integer := 24
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        in3             : in     vl_logic_vector;
        in4             : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 2;
end mux_4_input;

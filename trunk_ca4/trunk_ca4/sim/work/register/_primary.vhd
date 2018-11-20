library verilog;
use verilog.vl_types.all;
entity \register\ is
    generic(
        size            : integer := 32
    );
    port(
        clock           : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic;
        regIn           : in     vl_logic_vector;
        regOut          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size : constant is 2;
end \register\;

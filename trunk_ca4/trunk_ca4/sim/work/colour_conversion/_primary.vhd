library verilog;
use verilog.vl_types.all;
entity colour_conversion is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clear           : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        Wrenb           : out    vl_logic;
        W_data          : out    vl_logic_vector(15 downto 0);
        R_data          : in     vl_logic_vector(15 downto 0)
    );
end colour_conversion;

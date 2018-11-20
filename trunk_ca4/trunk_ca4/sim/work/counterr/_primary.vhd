library verilog;
use verilog.vl_types.all;
entity counterr is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic;
        counter         : out    vl_logic_vector(17 downto 0)
    );
end counterr;

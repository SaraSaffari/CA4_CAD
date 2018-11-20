library verilog;
use verilog.vl_types.all;
entity colour_conversion_controller is
    generic(
        IDLE            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        \WAIT\          : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        READ0           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        READ1           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        READ2           : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0);
        READ3           : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi1);
        READ4           : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi0);
        READ5           : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clear           : out    vl_logic;
        start           : in     vl_logic;
        Smux1           : out    vl_logic;
        Smux2           : out    vl_logic_vector(1 downto 0);
        Wrenb           : out    vl_logic;
        Yen_odd         : out    vl_logic;
        Uen_odd         : out    vl_logic;
        Ven_odd         : out    vl_logic;
        Temp_en         : out    vl_logic;
        Yen_even        : out    vl_logic;
        Uen_even        : out    vl_logic;
        Ven_even        : out    vl_logic;
        Cen             : out    vl_logic;
        done            : out    vl_logic;
        end_of_pixel    : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of \WAIT\ : constant is 2;
    attribute mti_svvh_generic_type of READ0 : constant is 2;
    attribute mti_svvh_generic_type of READ1 : constant is 2;
    attribute mti_svvh_generic_type of READ2 : constant is 2;
    attribute mti_svvh_generic_type of READ3 : constant is 2;
    attribute mti_svvh_generic_type of READ4 : constant is 2;
    attribute mti_svvh_generic_type of READ5 : constant is 2;
end colour_conversion_controller;

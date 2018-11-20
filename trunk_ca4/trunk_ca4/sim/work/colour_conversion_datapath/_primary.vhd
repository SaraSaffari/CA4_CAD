library verilog;
use verilog.vl_types.all;
entity colour_conversion_datapath is
    generic(
        x1y1            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0);
        x2y1            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        x3y1            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1);
        x1y2            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0);
        x2y2            : vl_logic_vector(19 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0);
        x3y2            : vl_logic_vector(19 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        x1y3            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0);
        x2y3            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1);
        x3y3            : vl_logic_vector(19 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        R_data          : in     vl_logic_vector(15 downto 0);
        Yen_odd         : in     vl_logic;
        Uen_odd         : in     vl_logic;
        Ven_odd         : in     vl_logic;
        Yen_even        : in     vl_logic;
        Uen_even        : in     vl_logic;
        Ven_even        : in     vl_logic;
        Smux1           : in     vl_logic;
        Smux2           : in     vl_logic_vector(1 downto 0);
        Cen             : in     vl_logic;
        Temp_en         : in     vl_logic;
        end_of_pixel    : out    vl_logic;
        W_data          : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of x1y1 : constant is 2;
    attribute mti_svvh_generic_type of x2y1 : constant is 2;
    attribute mti_svvh_generic_type of x3y1 : constant is 2;
    attribute mti_svvh_generic_type of x1y2 : constant is 2;
    attribute mti_svvh_generic_type of x2y2 : constant is 2;
    attribute mti_svvh_generic_type of x3y2 : constant is 2;
    attribute mti_svvh_generic_type of x1y3 : constant is 2;
    attribute mti_svvh_generic_type of x2y3 : constant is 2;
    attribute mti_svvh_generic_type of x3y3 : constant is 2;
end colour_conversion_datapath;

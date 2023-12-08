library ieee;
    use ieee.std_logic_1164.all;

entity GPIO_BANK is
    generic (
        G_NUM_PINS : positive := 8
    );
    port (
        I_CLK           : in    std_logic;
        I_RESET         : in    std_logic;

        I_GPIO_DIR      : in    std_logic_vector(G_NUM_PINS-1 downto 0);
        I_GPIO_OUT_DATA : in    std_logic_vector(G_NUM_PINS-1 downto 0);
        O_GPIO_IN_DATA  : out   std_logic_vector(G_NUM_PINS-1 downto 0);

        IO_GPIO_PINS    : inout std_logic_vector(G_NUM_PINS-1 downto 0)
    );
end entity GPIO_BANK;

library ieee;
    use ieee.std_logic_1164.all;

package GPIO_BANK_COMP_PKG is

    component GPIO_BANK is
        generic (
            G_NUM_PINS : positive := 8
        );
        port (
            I_CLK           : in    std_logic;
            I_RESET         : in    std_logic;
    
            I_GPIO_DIR      : in    std_logic_vector(G_NUM_PINS-1 downto 0);
            I_GPIO_OUT_DATA : in    std_logic_vector(G_NUM_PINS-1 downto 0);
            O_GPIO_IN_DATA  : out   std_logic_vector(G_NUM_PINS-1 downto 0);
    
            IO_GPIO_PINS    : inout std_logic_vector(G_NUM_PINS-1 downto 0)
        );
    end component GPIO_BANK;

end package GPIO_BANK_COMP_PKG;
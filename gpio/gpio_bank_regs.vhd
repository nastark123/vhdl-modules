library ieee;
    use ieee.std_logic_1164.all;

entity GPIO_BANK_REGS is
    generic (
        G_BANK_SIZE : positive := 8;
        G_DATA_SIZE : positive := 8;
        G_ADDR_SIZE : positive := 16;
        G_BASE_ADDR : std_logic_vector(G_ADDR_SIZE - 1 downto 0) := (others => '0')
    );
    port (
        I_CLK      : in  std_logic;
        I_RESET    : in  std_logic;

        I_ADDR     : in  std_logic_vector(G_ADDR_SIZE - 1 downto 0);
        I_WR_DATA  : in  std_logic_vector(G_DATA_SIZE - 1 downto 0);
        I_WR_EN    : in  std_logic;
        O_RD_DATA  : out std_logic_vector(G_DATA_SIZE - 1 downto 0);
        O_RD_VALID : out std_logic;

        O_GPIO_DIR      : out std_logic_vector(G_BANK_SIZE - 1 downto 0);
        O_GPIO_OUT_DATA  : out std_logic_vector(G_BANK_SIZE - 1 downto 0);
        I_GPIO_IN_DATA : in  std_logic_vector(G_BANK_SIZE - 1 downto 0)
    );
end entity GPIO_BANK_REGS;

library ieee;
    use ieee.std_logic_1164.all;

package GPIO_BANK_REGS_COMP_PKG is

    component GPIO_BANK_REGS is
        generic (
            G_BANK_SIZE : positive := 8;
            G_DATA_SIZE : positive := 8;
            G_ADDR_SIZE : positive := 16;
            G_BASE_ADDR : std_logic_vector(G_ADDR_SIZE - 1 downto 0) := (others => '0')
        );
        port (
            I_CLK      : in  std_logic;
            I_RESET    : in  std_logic;

            I_ADDR     : in  std_logic_vector(G_ADDR_SIZE - 1 downto 0);
            I_WR_DATA  : in  std_logic_vector(G_DATA_SIZE - 1 downto 0);
            I_WR_EN    : in  std_logic;
            O_RD_DATA  : out std_logic_vector(G_DATA_SIZE - 1 downto 0);
            O_RD_VALID : out std_logic;

            O_GPIO_DIR      : out std_logic_vector(G_BANK_SIZE - 1 downto 0);
            O_GPIO_OUT_DATA  : out std_logic_vector(G_BANK_SIZE - 1 downto 0);
            I_GPIO_IN_DATA : in  std_logic_vector(G_BANK_SIZE - 1 downto 0)
        );
    end component GPIO_BANK_REGS;

end package GPIO_BANK_REGS_COMP_PKG;
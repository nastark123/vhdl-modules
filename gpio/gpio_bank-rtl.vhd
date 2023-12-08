library ieee;
    use ieee.std_logic_1164.all;

architecture RTL of GPIO_BANK is

    -- internal registers and signals
    signal q_data_in_meta, n_data_in_meta : std_logic_vector(G_NUM_PINS-1 downto 0);
    signal q_data_in_sync, n_data_in_sync : std_logic_vector(G_NUM_PINS-1 downto 0);

begin

    -- output signal assignments
    PIN_GEN : for I in G_NUM_PINS - 1 downto 0 generate
        IO_GPIO_PINS(I)   <= I_GPIO_OUT_DATA(I) when I_GPIO_DIR(I) = '1' else 'Z';
    end generate;
        
    O_GPIO_IN_DATA <= q_data_in_sync;

    -- synchronous process
    SYNC : process(I_RESET, I_CLK)
    begin

        if I_RESET = '1' then
            q_data_in_meta <= (others => '0');
            q_data_in_sync <= (others => '0');
        elsif rising_edge(I_CLK) then
            q_data_in_meta <= n_data_in_meta;
            q_data_in_sync <= n_data_in_sync;
        end if;

    end process SYNC;

end architecture RTL;
	component probe_pc is
		port (
			probe : in std_logic_vector(31 downto 0) := (others => 'X')  -- probe
		);
	end component probe_pc;

	u0 : component probe_pc
		port map (
			probe => CONNECTED_TO_probe  -- probes.probe
		);


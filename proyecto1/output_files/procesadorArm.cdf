/* Quartus Prime Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(5CSEMA5F31) MfrSpec(OpMask(0) FullPath("D:/Proyectos/Quartus/Arqui-II-Proyecto-I/proyecto1/output_files/procesadorArm.sof"));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5F31) Path("D:/Proyectos/Quartus/Arqui-II-Proyecto-I/proyecto1/output_files/") File("procesadorArm.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
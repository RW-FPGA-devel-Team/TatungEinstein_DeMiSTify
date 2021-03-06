library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"00183c24",
     1 => x"243c1800",
     2 => x"00fcfc24",
     3 => x"047c7c00",
     4 => x"00080c04",
     5 => x"545c4800",
     6 => x"00207454",
     7 => x"7f3f0400",
     8 => x"00004444",
     9 => x"407c3c00",
    10 => x"007c7c40",
    11 => x"603c1c00",
    12 => x"001c3c60",
    13 => x"30607c3c",
    14 => x"003c7c60",
    15 => x"10386c44",
    16 => x"00446c38",
    17 => x"e0bc1c00",
    18 => x"001c3c60",
    19 => x"74644400",
    20 => x"00444c5c",
    21 => x"3e080800",
    22 => x"00414177",
    23 => x"7f000000",
    24 => x"0000007f",
    25 => x"77414100",
    26 => x"0008083e",
    27 => x"03010102",
    28 => x"00010202",
    29 => x"7f7f7f7f",
    30 => x"007f7f7f",
    31 => x"1c1c0808",
    32 => x"7f7f3e3e",
    33 => x"3e3e7f7f",
    34 => x"08081c1c",
    35 => x"7c181000",
    36 => x"0010187c",
    37 => x"7c301000",
    38 => x"0010307c",
    39 => x"60603010",
    40 => x"00061e78",
    41 => x"183c6642",
    42 => x"0042663c",
    43 => x"c26a3878",
    44 => x"00386cc6",
    45 => x"60000060",
    46 => x"00600000",
    47 => x"5c5b5e0e",
    48 => x"711e0e5d",
    49 => x"c1edc24c",
    50 => x"4bc04dbf",
    51 => x"ab741ec0",
    52 => x"c487c702",
    53 => x"78c048a6",
    54 => x"a6c487c5",
    55 => x"c478c148",
    56 => x"49731e66",
    57 => x"c887dfee",
    58 => x"49e0c086",
    59 => x"c487eeef",
    60 => x"496a4aa5",
    61 => x"f187f0f0",
    62 => x"85cb87c6",
    63 => x"b7c883c1",
    64 => x"c7ff04ab",
    65 => x"4d262687",
    66 => x"4b264c26",
    67 => x"711e4f26",
    68 => x"c5edc24a",
    69 => x"c5edc25a",
    70 => x"4978c748",
    71 => x"2687ddfe",
    72 => x"1e731e4f",
    73 => x"b7c04a71",
    74 => x"87d303aa",
    75 => x"bfdbd3c2",
    76 => x"c187c405",
    77 => x"c087c24b",
    78 => x"dfd3c24b",
    79 => x"c287c45b",
    80 => x"c25adfd3",
    81 => x"4abfdbd3",
    82 => x"c0c19ac1",
    83 => x"e8ec49a2",
    84 => x"c248fc87",
    85 => x"78bfdbd3",
    86 => x"1e87effe",
    87 => x"66c44a71",
    88 => x"ea49721e",
    89 => x"262687ee",
    90 => x"d4ff1e4f",
    91 => x"78ffc348",
    92 => x"c048d0ff",
    93 => x"d4ff78e1",
    94 => x"7178c148",
    95 => x"ff30c448",
    96 => x"ff7808d4",
    97 => x"e0c048d0",
    98 => x"0e4f2678",
    99 => x"5d5c5b5e",
   100 => x"c486f40e",
   101 => x"78c048a6",
   102 => x"7ebfec4b",
   103 => x"bfc1edc2",
   104 => x"4cbfe84d",
   105 => x"bfdbd3c2",
   106 => x"87d6e249",
   107 => x"cc49eecb",
   108 => x"a6cc87f1",
   109 => x"e649c758",
   110 => x"987087cb",
   111 => x"6e87c805",
   112 => x"0299c149",
   113 => x"c187c3c1",
   114 => x"7ebfec4b",
   115 => x"bfdbd3c2",
   116 => x"87eee149",
   117 => x"cc4966c8",
   118 => x"987087d5",
   119 => x"c287d802",
   120 => x"49bfd3d3",
   121 => x"d3c2b9c1",
   122 => x"fd7159d7",
   123 => x"eecb87fb",
   124 => x"87efcb49",
   125 => x"c758a6cc",
   126 => x"87c9e549",
   127 => x"ff059870",
   128 => x"496e87c5",
   129 => x"fe0599c1",
   130 => x"9b7387fd",
   131 => x"ff87d002",
   132 => x"87cdfc49",
   133 => x"e449dac1",
   134 => x"a6c487eb",
   135 => x"c278c148",
   136 => x"05bfdbd3",
   137 => x"c387e9c0",
   138 => x"d8e449fd",
   139 => x"49fac387",
   140 => x"7487d2e4",
   141 => x"99ffc349",
   142 => x"49c01e71",
   143 => x"7487dcfc",
   144 => x"29b7c849",
   145 => x"49c11e71",
   146 => x"c887d0fc",
   147 => x"87edc886",
   148 => x"ffc34974",
   149 => x"2cb7c899",
   150 => x"9c74b471",
   151 => x"c287dd02",
   152 => x"49bfd7d3",
   153 => x"7087c8ca",
   154 => x"87c40598",
   155 => x"87d24cc0",
   156 => x"c949e0c2",
   157 => x"d3c287ed",
   158 => x"87c658db",
   159 => x"48d7d3c2",
   160 => x"497478c0",
   161 => x"cd0599c2",
   162 => x"49ebc387",
   163 => x"7087f6e2",
   164 => x"0299c249",
   165 => x"d8c187cf",
   166 => x"bf6e7ea5",
   167 => x"87c5c002",
   168 => x"7349fb4b",
   169 => x"c149740f",
   170 => x"87cd0599",
   171 => x"e249f4c3",
   172 => x"497087d3",
   173 => x"cf0299c2",
   174 => x"a5d8c187",
   175 => x"02bf6e7e",
   176 => x"4b87c5c0",
   177 => x"0f7349fa",
   178 => x"99c84974",
   179 => x"c387ce05",
   180 => x"f0e149f5",
   181 => x"c2497087",
   182 => x"e5c00299",
   183 => x"c5edc287",
   184 => x"cac002bf",
   185 => x"88c14887",
   186 => x"58c9edc2",
   187 => x"c187cec0",
   188 => x"6a4aa5d8",
   189 => x"87c5c002",
   190 => x"7349ff4b",
   191 => x"48a6c40f",
   192 => x"497478c1",
   193 => x"c00599c4",
   194 => x"f2c387ce",
   195 => x"87f5e049",
   196 => x"99c24970",
   197 => x"87ecc002",
   198 => x"bfc5edc2",
   199 => x"b7c7487e",
   200 => x"cbc003a8",
   201 => x"c1486e87",
   202 => x"c9edc280",
   203 => x"87cfc058",
   204 => x"7ea5d8c1",
   205 => x"c002bf6e",
   206 => x"fe4b87c5",
   207 => x"c40f7349",
   208 => x"78c148a6",
   209 => x"ff49fdc3",
   210 => x"7087fadf",
   211 => x"0299c249",
   212 => x"c287e5c0",
   213 => x"02bfc5ed",
   214 => x"c287c9c0",
   215 => x"c048c5ed",
   216 => x"87cfc078",
   217 => x"7ea5d8c1",
   218 => x"c002bf6e",
   219 => x"fd4b87c5",
   220 => x"c40f7349",
   221 => x"78c148a6",
   222 => x"ff49fac3",
   223 => x"7087c6df",
   224 => x"0299c249",
   225 => x"c287e9c0",
   226 => x"48bfc5ed",
   227 => x"03a8b7c7",
   228 => x"c287c9c0",
   229 => x"c748c5ed",
   230 => x"87cfc078",
   231 => x"7ea5d8c1",
   232 => x"c002bf6e",
   233 => x"fc4b87c5",
   234 => x"c40f7349",
   235 => x"78c148a6",
   236 => x"edc24bc0",
   237 => x"50c048c0",
   238 => x"c449eecb",
   239 => x"a6cc87e5",
   240 => x"c0edc258",
   241 => x"c105bf97",
   242 => x"497487de",
   243 => x"0599f0c3",
   244 => x"c187cdc0",
   245 => x"ddff49da",
   246 => x"987087eb",
   247 => x"87c8c102",
   248 => x"bfe84bc1",
   249 => x"ffc3494c",
   250 => x"2cb7c899",
   251 => x"d3c2b471",
   252 => x"ff49bfdb",
   253 => x"c887cbd9",
   254 => x"f2c34966",
   255 => x"02987087",
   256 => x"c287c6c0",
   257 => x"c148c0ed",
   258 => x"c0edc250",
   259 => x"c005bf97",
   260 => x"497487d6",
   261 => x"0599f0c3",
   262 => x"c187c5ff",
   263 => x"dcff49da",
   264 => x"987087e3",
   265 => x"87f8fe05",
   266 => x"c0029b73",
   267 => x"a6c887dc",
   268 => x"c5edc248",
   269 => x"66c878bf",
   270 => x"7591cb49",
   271 => x"bf6e7ea1",
   272 => x"87c6c002",
   273 => x"4966c84b",
   274 => x"66c40f73",
   275 => x"87c8c002",
   276 => x"bfc5edc2",
   277 => x"87e4f149",
   278 => x"bfdfd3c2",
   279 => x"87ddc002",
   280 => x"87cbc249",
   281 => x"c0029870",
   282 => x"edc287d3",
   283 => x"f149bfc5",
   284 => x"49c087ca",
   285 => x"c287eaf2",
   286 => x"c048dfd3",
   287 => x"f28ef478",
   288 => x"5e0e87c4",
   289 => x"0e5d5c5b",
   290 => x"c24c711e",
   291 => x"49bfc1ed",
   292 => x"4da1cdc1",
   293 => x"6981d1c1",
   294 => x"029c747e",
   295 => x"a5c487cf",
   296 => x"c27b744b",
   297 => x"49bfc1ed",
   298 => x"6e87e3f1",
   299 => x"059c747b",
   300 => x"4bc087c4",
   301 => x"4bc187c2",
   302 => x"e4f14973",
   303 => x"0266d487",
   304 => x"de4987c7",
   305 => x"c24a7087",
   306 => x"c24ac087",
   307 => x"265ae3d3",
   308 => x"0087f3f0",
   309 => x"00000000",
   310 => x"00000000",
   311 => x"00000000",
   312 => x"1e000000",
   313 => x"c8ff4a71",
   314 => x"a17249bf",
   315 => x"1e4f2648",
   316 => x"89bfc8ff",
   317 => x"c0c0c0fe",
   318 => x"01a9c0c0",
   319 => x"4ac087c4",
   320 => x"4ac187c2",
   321 => x"4f264872",
   322 => x"5c5b5e0e",
   323 => x"4b710e5d",
   324 => x"d04cd4ff",
   325 => x"78c04866",
   326 => x"daff49d6",
   327 => x"ffc387df",
   328 => x"c3496c7c",
   329 => x"4d7199ff",
   330 => x"99f0c349",
   331 => x"05a9e0c1",
   332 => x"ffc387cb",
   333 => x"c3486c7c",
   334 => x"0866d098",
   335 => x"7cffc378",
   336 => x"c8494a6c",
   337 => x"7cffc331",
   338 => x"b2714a6c",
   339 => x"31c84972",
   340 => x"6c7cffc3",
   341 => x"72b2714a",
   342 => x"c331c849",
   343 => x"4a6c7cff",
   344 => x"d0ffb271",
   345 => x"78e0c048",
   346 => x"c2029b73",
   347 => x"757b7287",
   348 => x"264d2648",
   349 => x"264b264c",
   350 => x"4f261e4f",
   351 => x"5c5b5e0e",
   352 => x"7686f80e",
   353 => x"49a6c81e",
   354 => x"c487fdfd",
   355 => x"6e4b7086",
   356 => x"01a8c048",
   357 => x"7387f0c2",
   358 => x"9af0c34a",
   359 => x"02aad0c1",
   360 => x"e0c187c7",
   361 => x"dec205aa",
   362 => x"c8497387",
   363 => x"87c30299",
   364 => x"7387c6ff",
   365 => x"c29cc34c",
   366 => x"c2c105ac",
   367 => x"4966c487",
   368 => x"1e7131c9",
   369 => x"d44a66c4",
   370 => x"c9edc292",
   371 => x"fe817249",
   372 => x"d887f4cf",
   373 => x"e4d7ff49",
   374 => x"1ec0c887",
   375 => x"49f2dbc2",
   376 => x"87faebfd",
   377 => x"c048d0ff",
   378 => x"dbc278e0",
   379 => x"66cc1ef2",
   380 => x"c292d44a",
   381 => x"7249c9ed",
   382 => x"fccdfe81",
   383 => x"c186cc87",
   384 => x"c2c105ac",
   385 => x"4966c487",
   386 => x"1e7131c9",
   387 => x"d44a66c4",
   388 => x"c9edc292",
   389 => x"fe817249",
   390 => x"c287ecce",
   391 => x"c81ef2db",
   392 => x"92d44a66",
   393 => x"49c9edc2",
   394 => x"cbfe8172",
   395 => x"49d787fd",
   396 => x"87c9d6ff",
   397 => x"c21ec0c8",
   398 => x"fd49f2db",
   399 => x"cc87f8e9",
   400 => x"48d0ff86",
   401 => x"f878e0c0",
   402 => x"87e7fc8e",
   403 => x"5c5b5e0e",
   404 => x"4a710e5d",
   405 => x"d04cd4ff",
   406 => x"b7c34d66",
   407 => x"87c506ad",
   408 => x"e1c148c0",
   409 => x"751e7287",
   410 => x"c293d44b",
   411 => x"7383c9ed",
   412 => x"c4c6fe49",
   413 => x"6b83c887",
   414 => x"48d0ff4b",
   415 => x"dd78e1c8",
   416 => x"c348737c",
   417 => x"7c7098ff",
   418 => x"b7c84973",
   419 => x"c3487129",
   420 => x"7c7098ff",
   421 => x"b7d04973",
   422 => x"c3487129",
   423 => x"7c7098ff",
   424 => x"b7d84873",
   425 => x"c07c7028",
   426 => x"7c7c7c7c",
   427 => x"7c7c7c7c",
   428 => x"7c7c7c7c",
   429 => x"c048d0ff",
   430 => x"1e7578e0",
   431 => x"d4ff49dc",
   432 => x"86c887e0",
   433 => x"e8fa4873",
   434 => x"e8fa4887",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;

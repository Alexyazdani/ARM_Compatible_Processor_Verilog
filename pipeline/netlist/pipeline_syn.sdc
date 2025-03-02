###################################################################

# Created by write_sdc on Fri Feb 28 19:47:53 2025

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 10  -waveform {0 5}
set_max_delay 10  -to [get_ports {imem_out[31]}]
set_max_delay 10  -to [get_ports {imem_out[30]}]
set_max_delay 10  -to [get_ports {imem_out[29]}]
set_max_delay 10  -to [get_ports {imem_out[28]}]
set_max_delay 10  -to [get_ports {imem_out[27]}]
set_max_delay 10  -to [get_ports {imem_out[26]}]
set_max_delay 10  -to [get_ports {imem_out[25]}]
set_max_delay 10  -to [get_ports {imem_out[24]}]
set_max_delay 10  -to [get_ports {imem_out[23]}]
set_max_delay 10  -to [get_ports {imem_out[22]}]
set_max_delay 10  -to [get_ports {imem_out[21]}]
set_max_delay 10  -to [get_ports {imem_out[20]}]
set_max_delay 10  -to [get_ports {imem_out[19]}]
set_max_delay 10  -to [get_ports {imem_out[18]}]
set_max_delay 10  -to [get_ports {imem_out[17]}]
set_max_delay 10  -to [get_ports {imem_out[16]}]
set_max_delay 10  -to [get_ports {imem_out[15]}]
set_max_delay 10  -to [get_ports {imem_out[14]}]
set_max_delay 10  -to [get_ports {imem_out[13]}]
set_max_delay 10  -to [get_ports {imem_out[12]}]
set_max_delay 10  -to [get_ports {imem_out[11]}]
set_max_delay 10  -to [get_ports {imem_out[10]}]
set_max_delay 10  -to [get_ports {imem_out[9]}]
set_max_delay 10  -to [get_ports {imem_out[8]}]
set_max_delay 10  -to [get_ports {imem_out[7]}]
set_max_delay 10  -to [get_ports {imem_out[6]}]
set_max_delay 10  -to [get_ports {imem_out[5]}]
set_max_delay 10  -to [get_ports {imem_out[4]}]
set_max_delay 10  -to [get_ports {imem_out[3]}]
set_max_delay 10  -to [get_ports {imem_out[2]}]
set_max_delay 10  -to [get_ports {imem_out[1]}]
set_max_delay 10  -to [get_ports {imem_out[0]}]
set_max_delay 10  -to [get_ports {dmem_out[63]}]
set_max_delay 10  -to [get_ports {dmem_out[62]}]
set_max_delay 10  -to [get_ports {dmem_out[61]}]
set_max_delay 10  -to [get_ports {dmem_out[60]}]
set_max_delay 10  -to [get_ports {dmem_out[59]}]
set_max_delay 10  -to [get_ports {dmem_out[58]}]
set_max_delay 10  -to [get_ports {dmem_out[57]}]
set_max_delay 10  -to [get_ports {dmem_out[56]}]
set_max_delay 10  -to [get_ports {dmem_out[55]}]
set_max_delay 10  -to [get_ports {dmem_out[54]}]
set_max_delay 10  -to [get_ports {dmem_out[53]}]
set_max_delay 10  -to [get_ports {dmem_out[52]}]
set_max_delay 10  -to [get_ports {dmem_out[51]}]
set_max_delay 10  -to [get_ports {dmem_out[50]}]
set_max_delay 10  -to [get_ports {dmem_out[49]}]
set_max_delay 10  -to [get_ports {dmem_out[48]}]
set_max_delay 10  -to [get_ports {dmem_out[47]}]
set_max_delay 10  -to [get_ports {dmem_out[46]}]
set_max_delay 10  -to [get_ports {dmem_out[45]}]
set_max_delay 10  -to [get_ports {dmem_out[44]}]
set_max_delay 10  -to [get_ports {dmem_out[43]}]
set_max_delay 10  -to [get_ports {dmem_out[42]}]
set_max_delay 10  -to [get_ports {dmem_out[41]}]
set_max_delay 10  -to [get_ports {dmem_out[40]}]
set_max_delay 10  -to [get_ports {dmem_out[39]}]
set_max_delay 10  -to [get_ports {dmem_out[38]}]
set_max_delay 10  -to [get_ports {dmem_out[37]}]
set_max_delay 10  -to [get_ports {dmem_out[36]}]
set_max_delay 10  -to [get_ports {dmem_out[35]}]
set_max_delay 10  -to [get_ports {dmem_out[34]}]
set_max_delay 10  -to [get_ports {dmem_out[33]}]
set_max_delay 10  -to [get_ports {dmem_out[32]}]
set_max_delay 10  -to [get_ports {dmem_out[31]}]
set_max_delay 10  -to [get_ports {dmem_out[30]}]
set_max_delay 10  -to [get_ports {dmem_out[29]}]
set_max_delay 10  -to [get_ports {dmem_out[28]}]
set_max_delay 10  -to [get_ports {dmem_out[27]}]
set_max_delay 10  -to [get_ports {dmem_out[26]}]
set_max_delay 10  -to [get_ports {dmem_out[25]}]
set_max_delay 10  -to [get_ports {dmem_out[24]}]
set_max_delay 10  -to [get_ports {dmem_out[23]}]
set_max_delay 10  -to [get_ports {dmem_out[22]}]
set_max_delay 10  -to [get_ports {dmem_out[21]}]
set_max_delay 10  -to [get_ports {dmem_out[20]}]
set_max_delay 10  -to [get_ports {dmem_out[19]}]
set_max_delay 10  -to [get_ports {dmem_out[18]}]
set_max_delay 10  -to [get_ports {dmem_out[17]}]
set_max_delay 10  -to [get_ports {dmem_out[16]}]
set_max_delay 10  -to [get_ports {dmem_out[15]}]
set_max_delay 10  -to [get_ports {dmem_out[14]}]
set_max_delay 10  -to [get_ports {dmem_out[13]}]
set_max_delay 10  -to [get_ports {dmem_out[12]}]
set_max_delay 10  -to [get_ports {dmem_out[11]}]
set_max_delay 10  -to [get_ports {dmem_out[10]}]
set_max_delay 10  -to [get_ports {dmem_out[9]}]
set_max_delay 10  -to [get_ports {dmem_out[8]}]
set_max_delay 10  -to [get_ports {dmem_out[7]}]
set_max_delay 10  -to [get_ports {dmem_out[6]}]
set_max_delay 10  -to [get_ports {dmem_out[5]}]
set_max_delay 10  -to [get_ports {dmem_out[4]}]
set_max_delay 10  -to [get_ports {dmem_out[3]}]
set_max_delay 10  -to [get_ports {dmem_out[2]}]
set_max_delay 10  -to [get_ports {dmem_out[1]}]
set_max_delay 10  -to [get_ports {dmem_out[0]}]
set_max_delay 10  -to [get_ports {reg_out[63]}]
set_max_delay 10  -to [get_ports {reg_out[62]}]
set_max_delay 10  -to [get_ports {reg_out[61]}]
set_max_delay 10  -to [get_ports {reg_out[60]}]
set_max_delay 10  -to [get_ports {reg_out[59]}]
set_max_delay 10  -to [get_ports {reg_out[58]}]
set_max_delay 10  -to [get_ports {reg_out[57]}]
set_max_delay 10  -to [get_ports {reg_out[56]}]
set_max_delay 10  -to [get_ports {reg_out[55]}]
set_max_delay 10  -to [get_ports {reg_out[54]}]
set_max_delay 10  -to [get_ports {reg_out[53]}]
set_max_delay 10  -to [get_ports {reg_out[52]}]
set_max_delay 10  -to [get_ports {reg_out[51]}]
set_max_delay 10  -to [get_ports {reg_out[50]}]
set_max_delay 10  -to [get_ports {reg_out[49]}]
set_max_delay 10  -to [get_ports {reg_out[48]}]
set_max_delay 10  -to [get_ports {reg_out[47]}]
set_max_delay 10  -to [get_ports {reg_out[46]}]
set_max_delay 10  -to [get_ports {reg_out[45]}]
set_max_delay 10  -to [get_ports {reg_out[44]}]
set_max_delay 10  -to [get_ports {reg_out[43]}]
set_max_delay 10  -to [get_ports {reg_out[42]}]
set_max_delay 10  -to [get_ports {reg_out[41]}]
set_max_delay 10  -to [get_ports {reg_out[40]}]
set_max_delay 10  -to [get_ports {reg_out[39]}]
set_max_delay 10  -to [get_ports {reg_out[38]}]
set_max_delay 10  -to [get_ports {reg_out[37]}]
set_max_delay 10  -to [get_ports {reg_out[36]}]
set_max_delay 10  -to [get_ports {reg_out[35]}]
set_max_delay 10  -to [get_ports {reg_out[34]}]
set_max_delay 10  -to [get_ports {reg_out[33]}]
set_max_delay 10  -to [get_ports {reg_out[32]}]
set_max_delay 10  -to [get_ports {reg_out[31]}]
set_max_delay 10  -to [get_ports {reg_out[30]}]
set_max_delay 10  -to [get_ports {reg_out[29]}]
set_max_delay 10  -to [get_ports {reg_out[28]}]
set_max_delay 10  -to [get_ports {reg_out[27]}]
set_max_delay 10  -to [get_ports {reg_out[26]}]
set_max_delay 10  -to [get_ports {reg_out[25]}]
set_max_delay 10  -to [get_ports {reg_out[24]}]
set_max_delay 10  -to [get_ports {reg_out[23]}]
set_max_delay 10  -to [get_ports {reg_out[22]}]
set_max_delay 10  -to [get_ports {reg_out[21]}]
set_max_delay 10  -to [get_ports {reg_out[20]}]
set_max_delay 10  -to [get_ports {reg_out[19]}]
set_max_delay 10  -to [get_ports {reg_out[18]}]
set_max_delay 10  -to [get_ports {reg_out[17]}]
set_max_delay 10  -to [get_ports {reg_out[16]}]
set_max_delay 10  -to [get_ports {reg_out[15]}]
set_max_delay 10  -to [get_ports {reg_out[14]}]
set_max_delay 10  -to [get_ports {reg_out[13]}]
set_max_delay 10  -to [get_ports {reg_out[12]}]
set_max_delay 10  -to [get_ports {reg_out[11]}]
set_max_delay 10  -to [get_ports {reg_out[10]}]
set_max_delay 10  -to [get_ports {reg_out[9]}]
set_max_delay 10  -to [get_ports {reg_out[8]}]
set_max_delay 10  -to [get_ports {reg_out[7]}]
set_max_delay 10  -to [get_ports {reg_out[6]}]
set_max_delay 10  -to [get_ports {reg_out[5]}]
set_max_delay 10  -to [get_ports {reg_out[4]}]
set_max_delay 10  -to [get_ports {reg_out[3]}]
set_max_delay 10  -to [get_ports {reg_out[2]}]
set_max_delay 10  -to [get_ports {reg_out[1]}]
set_max_delay 10  -to [get_ports {reg_out[0]}]
set_max_delay 10  -to [get_ports N]
set_max_delay 10  -to [get_ports Z]
set_max_delay 10  -to [get_ports C]
set_max_delay 10  -to [get_ports V]
set_max_delay 10  -from [list [get_ports clk] [get_ports reset] [get_ports pipe_en] [get_ports  \
{imem_data[31]}] [get_ports {imem_data[30]}] [get_ports {imem_data[29]}]       \
[get_ports {imem_data[28]}] [get_ports {imem_data[27]}] [get_ports             \
{imem_data[26]}] [get_ports {imem_data[25]}] [get_ports {imem_data[24]}]       \
[get_ports {imem_data[23]}] [get_ports {imem_data[22]}] [get_ports             \
{imem_data[21]}] [get_ports {imem_data[20]}] [get_ports {imem_data[19]}]       \
[get_ports {imem_data[18]}] [get_ports {imem_data[17]}] [get_ports             \
{imem_data[16]}] [get_ports {imem_data[15]}] [get_ports {imem_data[14]}]       \
[get_ports {imem_data[13]}] [get_ports {imem_data[12]}] [get_ports             \
{imem_data[11]}] [get_ports {imem_data[10]}] [get_ports {imem_data[9]}]        \
[get_ports {imem_data[8]}] [get_ports {imem_data[7]}] [get_ports               \
{imem_data[6]}] [get_ports {imem_data[5]}] [get_ports {imem_data[4]}]          \
[get_ports {imem_data[3]}] [get_ports {imem_data[2]}] [get_ports               \
{imem_data[1]}] [get_ports {imem_data[0]}] [get_ports {imem_addr[8]}]          \
[get_ports {imem_addr[7]}] [get_ports {imem_addr[6]}] [get_ports               \
{imem_addr[5]}] [get_ports {imem_addr[4]}] [get_ports {imem_addr[3]}]          \
[get_ports {imem_addr[2]}] [get_ports {imem_addr[1]}] [get_ports               \
{imem_addr[0]}] [get_ports imem_we] [get_ports imem_re] [get_ports             \
{dmem_data[63]}] [get_ports {dmem_data[62]}] [get_ports {dmem_data[61]}]       \
[get_ports {dmem_data[60]}] [get_ports {dmem_data[59]}] [get_ports             \
{dmem_data[58]}] [get_ports {dmem_data[57]}] [get_ports {dmem_data[56]}]       \
[get_ports {dmem_data[55]}] [get_ports {dmem_data[54]}] [get_ports             \
{dmem_data[53]}] [get_ports {dmem_data[52]}] [get_ports {dmem_data[51]}]       \
[get_ports {dmem_data[50]}] [get_ports {dmem_data[49]}] [get_ports             \
{dmem_data[48]}] [get_ports {dmem_data[47]}] [get_ports {dmem_data[46]}]       \
[get_ports {dmem_data[45]}] [get_ports {dmem_data[44]}] [get_ports             \
{dmem_data[43]}] [get_ports {dmem_data[42]}] [get_ports {dmem_data[41]}]       \
[get_ports {dmem_data[40]}] [get_ports {dmem_data[39]}] [get_ports             \
{dmem_data[38]}] [get_ports {dmem_data[37]}] [get_ports {dmem_data[36]}]       \
[get_ports {dmem_data[35]}] [get_ports {dmem_data[34]}] [get_ports             \
{dmem_data[33]}] [get_ports {dmem_data[32]}] [get_ports {dmem_data[31]}]       \
[get_ports {dmem_data[30]}] [get_ports {dmem_data[29]}] [get_ports             \
{dmem_data[28]}] [get_ports {dmem_data[27]}] [get_ports {dmem_data[26]}]       \
[get_ports {dmem_data[25]}] [get_ports {dmem_data[24]}] [get_ports             \
{dmem_data[23]}] [get_ports {dmem_data[22]}] [get_ports {dmem_data[21]}]       \
[get_ports {dmem_data[20]}] [get_ports {dmem_data[19]}] [get_ports             \
{dmem_data[18]}] [get_ports {dmem_data[17]}] [get_ports {dmem_data[16]}]       \
[get_ports {dmem_data[15]}] [get_ports {dmem_data[14]}] [get_ports             \
{dmem_data[13]}] [get_ports {dmem_data[12]}] [get_ports {dmem_data[11]}]       \
[get_ports {dmem_data[10]}] [get_ports {dmem_data[9]}] [get_ports              \
{dmem_data[8]}] [get_ports {dmem_data[7]}] [get_ports {dmem_data[6]}]          \
[get_ports {dmem_data[5]}] [get_ports {dmem_data[4]}] [get_ports               \
{dmem_data[3]}] [get_ports {dmem_data[2]}] [get_ports {dmem_data[1]}]          \
[get_ports {dmem_data[0]}] [get_ports {dmem_addr[7]}] [get_ports               \
{dmem_addr[6]}] [get_ports {dmem_addr[5]}] [get_ports {dmem_addr[4]}]          \
[get_ports {dmem_addr[3]}] [get_ports {dmem_addr[2]}] [get_ports               \
{dmem_addr[1]}] [get_ports {dmem_addr[0]}] [get_ports dmem_we] [get_ports      \
dmem_re] [get_ports reg_re] [get_ports {reg_addr[3]}] [get_ports               \
{reg_addr[2]}] [get_ports {reg_addr[1]}] [get_ports {reg_addr[0]}]]

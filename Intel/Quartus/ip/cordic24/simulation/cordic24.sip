set_global_assignment -entity "cordic24" -library "lib_cordic24" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "cordic24" -library "lib_cordic24" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "cordic24" -library "lib_cordic24" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_cordic24" -name SPD_FILE [file join $::quartus(sip_path) "../cordic24.spd"]
set_global_assignment -library "lib_cordic24" -name MISC_FILE [file join $::quartus(sip_path) "../../cordic24.qsys"]

set_global_assignment -library "lib_cordic24" -name MISC_FILE [file join $::quartus(sip_path) "cordic24.v"]
set_global_assignment -library "lib_cordic24" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library_package.vhd"]
set_global_assignment -library "lib_cordic24" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library.vhd"]
set_global_assignment -library "lib_cordic24" -name MISC_FILE [file join $::quartus(sip_path) "submodules/cordic24_CORDIC_0.vhd"]

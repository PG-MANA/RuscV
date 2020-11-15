MEMORY {
    rom : ORIGIN = 0x20000000, LENGTH = 16M
    ram : ORIGIN = 0x80000000, LENGTH = 0x4000
}

ENTRY(start)

SECTIONS {
    .text : {*(.text*)} > rom
    .rodata : {*(.rodata*)} > rom
    .bss : {*(.bss*)} > ram
} 

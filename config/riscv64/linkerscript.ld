
SECTIONS {

  ENTRY(_main) /*起動処理のコード*/
  . = 0x80000000;
  LD_KERNEL_START = .;

  .text BLOCK(4K): ALIGN(4K) {
    *(.boot_entry)
    *(.text*)
  }

  .data BLOCK(4K): ALIGN(4K) {
    *(.data*)
  }

  .rodata BLOCK(4K): ALIGN(4K) {
    *(.rodata*)
  }

  .bss BLOCK(4K): ALIGN(4K) {
    *(.bss*)
  }

  .data.rel.ro BLOCK(4K): ALIGN(4K) { /*動的再配置?*/
    *(.data.rel.ro*)
  }
}

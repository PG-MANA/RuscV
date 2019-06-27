#![no_std]
#![feature(asm)]
#![feature(global_asm)]
#![feature(core_panic_info)]

//use
use core::panic;

#[no_mangle]
pub extern "C" fn main() {
    let buf: *mut u8 = 0x10000000 as *mut u8;
    for c in "Hello, RISC-V!".as_bytes() {
        unsafe { *buf = *c };
        loop {
            if unsafe { *(((buf as usize) + 5) as *const u8) & 0x40 != 0 } {
                break;
            }
        }
    }
    loop {}
}

#[panic_handler]
#[no_mangle]
pub fn panic(_info: &panic::PanicInfo) -> ! {
    loop {}
}

#[cfg(target_arch = "riscv64")]
global_asm!(
    r#"
.global _main,stack

.section .boot_entry, "ax",@progbits

_main:
lla     sp, stack
j main

.align 8

.section .bss

.skip 512 * 2
stack:
"#
);

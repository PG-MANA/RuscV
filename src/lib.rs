#![no_std]
#![feature(asm)]
#![feature(global_asm)]

//use
use core::panic;
use core::ptr;

const UART0_BASE_ADDRESS: usize = 0x10013000;

struct Uart {
    base_address: usize,
}

impl Uart {
    const TX_INFO: usize = 0x0;
    const TX_CTRL: usize = 0x8;

    pub const fn new(base_address: usize) -> Self {
        Self { base_address }
    }

    pub fn init(&self) {
        unsafe {
            ptr::write_volatile(
                (self.base_address + Self::TX_CTRL) as *mut u32,
                0x00000001 + 0x10000,
            )
        };
    }

    fn is_tx_buffer_full(&self) -> bool {
        unsafe {
            ptr::read_volatile((self.base_address + Self::TX_INFO) as *mut u32) & (1 << 31) != 0
        }
    }

    pub fn putc(&self, c: u8) {
        while self.is_tx_buffer_full() {}
        unsafe { ptr::write_volatile((self.base_address + Self::TX_INFO) as *mut u32, c as u32) };
    }

    pub fn puts(&self, s: &str) {
        for c in s.as_bytes() {
            self.putc(*c);
        }
        self.putc('\r' as u8);
        self.putc('\n' as u8);
    }
}

#[no_mangle]
pub extern "C" fn main() {
    //init
    let uart0 = Uart::new(UART0_BASE_ADDRESS);
    uart0.init();
    uart0.puts("Hello, Sifive-FE310 on RENODE!!");

    halt_loop()
}

#[panic_handler]
#[no_mangle]
pub fn panic(_info: &panic::PanicInfo) -> ! {
    halt_loop();
}

pub fn halt_loop() -> ! {
    loop {
        unsafe { asm!("wfi") };
    }
}

#[cfg(target_arch = "riscv32")]
global_asm!(
    r#"
.global start

start:
lla     sp, stack
j main

.section .bss

.align 8
.skip 512 * 2
stack:
"#
);

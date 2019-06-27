#環境設定
##名前
NAME = ruscv

##ターゲット
TARGET_ARCH = $(2)
ifeq ($(strip $(TARGET_ARCH)),)
    TARGET_ARCH = riscv64
endif
RUST_TARGET = $(TARGET_ARCH)-unknown-none
#RUST_TARGET_FILE_FOLDER = target-json/ # https://github.com/japaric/xargo/issues/146

##ディレクトリ
SRC = src/
MAKE_BASEDIR ?= $(shell pwd)/
MAKE_BINDIR = $(MAKE_BASEDIR)bin/
MAKE_IMGDIR = $(MAKE_BINDIR)img/
MAKE_TMPDIR = $(MAKE_BASEDIR)tmp/
MAKE_OBJDIR = $(MAKE_TMPDIR)obj/
MAKE_CONGIGDIR =  $(MAKE_BASEDIR)config/$(TARGET_ARCH)/

##ソフトウェア
STRIP= riscv64-elf-strip
##↑変更
MKDIR = mkdir -p
CP = cp -r
RM = rm -rf
LD = riscv64-elf-ld -n --gc-sections -Map $(MAKE_TMPDIR)$(NAME).map -nostartfiles -nodefaultlibs -m elf64lriscv_lp64 -nostdlib -T $(MAKE_CONGIGDIR)linkerscript.ld
CARGO = cargo
QEMU = qemu-system-riscv64 --nographic -machine virt

##アセンブラ読み込み
include config/$(TARGET_ARCH)/assembler.mk
export AR

##ビルドファイル
KERNELFILES = kernel.elf
RUST_OBJ = target/$(RUST_TARGET)/release/lib$(NAME).a
BOOT_SYS_LIST = $(RUST_OBJ)

#初期設定
export TARGET_ARCH
export MAKE_BINDIR
export MAKE_TMPDIR
export MAKE_OBJDIR


#各コマンド
##デフォルト動作
default:
	$(MAKE) kernel
	-$(STRIP) $(MAKE_BINDIR)*.elf #できなくてもいい

##初期化動作
init:
	-$(MKDIR) $(MAKE_BINDIR)
	-$(MKDIR) $(MAKE_TMPDIR)
	-$(MKDIR) $(MAKE_OBJDIR)

clean:
	$(RM) $(MAKE_TMPDIR)
	$(CARGO) clean

kernel:
	$(MAKE) init
	$(MAKE) $(KERNELFILES)

run:
	$(MAKE) kernel
	$(QEMU) -kernel bin/kernel.elf

# ファイル生成規則
kernel.elf : $(BOOT_SYS_LIST)
	$(LD) -o $(MAKE_BINDIR)kernel.elf $(BOOT_SYS_LIST)

$(RUST_OBJ) :  .FORCE
	$(CARGO) xbuild --release --target $(RUST_TARGET_FILE_FOLDER) $(RUST_TARGET)

.FORCE:

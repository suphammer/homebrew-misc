class NakenAsm < Formula
  desc "naken_asm is a lightweight assembler / disassembler"
  homepage "https://www.mikekohn.net/micro/naken_asm.php"
  url "https://github.com/mikeakohn/naken_asm.git"
  version "head"
  sha256 ""
  license ""

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end

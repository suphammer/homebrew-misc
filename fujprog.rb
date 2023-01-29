class Fujprog < Formula
  desc "FPGA ULX2S / ULX3S JTAG programmer"
  homepage "https://github.com/kost/fujprog"
  url "https://github.com/kost/fujprog/archive/v4.8.zip"
  version "4.8"
  sha256 "e1d25cf18bf519daa2f349bc53949ee1c0563cd0b2dca14651565c9870d8f20b"

  depends_on "cmake"
  depends_on "pkg-config"
  depends_on "libftdi"
  depends_on "libusb"
  depends_on "libusb-compat"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end

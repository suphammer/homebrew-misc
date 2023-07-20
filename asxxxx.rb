class Asxxxx < Formula
  desc "ASxxxx Cross Assemblers"
  homepage "https://shop-pdp.net/"
  url "https://shop-pdp.net/_ftp/asxxxx/asxs5p40.zip"
  sha256 "ac8277b85308b9fdc3e27c50557cc3ba45fe0de85ddc96c936fb25e5fd3a3e22"
  version "5.40"
  license ""

  def install
    Dir.chdir('asxv5pxx/asxmak/linux/build')
    system "mkdir", "-p", "#{prefix}/bin"
    system "make", "DSTEXE=#{prefix}/bin/"
  end

  test do
    system "false"
  end
end

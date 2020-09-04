class Proxmark3 < Formula
  desc "RRG/Iceman Proxmark3 client, CDC flasher and firmware bundle w/Aliexpress board patch and QT disabled"
  homepage "http://www.proxmark.org/"
  url "https://github.com/RfidResearchGroup/proxmark3/archive/v4.9237.tar.gz"
  sha256 "db93c2d3b9b7f477aca5628ed0906d9dba9c1999080452b24c601f38ab5b5226"
  head do
    url "https://github.com/RfidResearchGroup/proxmark3.git"
  end
  
  depends_on "readline"
  depends_on "pkg-config" => :build

  patch do
    url "https://gist.githubusercontent.com/suphammer/79732ff728e41d71de3bfb08cb0b8d49/raw/24e3998c8def2e6993276c32841fbe3dda842a31/proxmark3-memory-sniffer.patch"
    sha256 "6213c2fe320a162847a7587d1efc18af0325fc37f81519f58f763a4256894759"
  end

  def install
    ENV.deparallelize

    ENV['HOMEBREW_PROXMARK3_PLATFORM'] = 'PM3OTHER'

    system "make", "clean"
    system "make", "client", "PLATFORM=#{ENV['HOMEBREW_PROXMARK3_PLATFORM']}"

    system "make", "client/install", "PREFIX=#{prefix}", "PLATFORM=#{ENV['HOMEBREW_PROXMARK3_PLATFORM']}"

    ohai "Install success!"
  end

  test do
    system "proxmark3", "-h"
  end
end

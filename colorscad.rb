# Documentation: "https://github.com/SkyTheCodeMaster/colorscad"
class Colorscad < Formula
  desc "Script to produce colorized OpenSCAD models"
  homepage "https://github.com/SkyTheCodeMaster/colorscad"
  url "https://github.com/SkyTheCodeMaster/colorscad/archive/83518dd98a7d38868c1703f09772f323175ddbb7.zip"
  sha256 "fbe9589de3c6a2d9f78ad6b8f76a6ea37d6e3b4ff68caf0475603866f780d6dc"
  license "NOASSERTION"
  version "modname"

  depends_on "cmake"
  depends_on "pkg-config"
  depends_on "lib3mf"

  def install
    system "cmake", "-S", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "bin/test"
  end
end

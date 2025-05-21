class Lib3mf < Formula
  desc "Library for the 3D Manufacturing Format (3MF)"
  homepage "https://github.com/3MFConsortium/lib3mf"
  url "https://github.com/3MFConsortium/lib3mf/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "96e85e278fc5474123e3c47237dd42faaf1fdf8e182541a84af7fe84ddd3cbde"
  version "2.2.0"
  license "BSD-2-Clause"

  depends_on "cmake" => :build

  def install
    puts "🔧 PATCHING top-level CMakeLists.txt"

    cmake_file = "CMakeLists.txt"
    contents = File.read(cmake_file)

    puts "🔍 First few lines:"
    puts contents.lines.first(10)

    # Inject cmake_minimum_required if missing
    if contents !~ /cmake_minimum_required/i
      if contents =~ /project\s*\(lib3mf.*?\)/i
        contents.sub!(/project\s*\(lib3mf.*?\)/i) do |match|
          "cmake_minimum_required(VERSION 3.5)\n#{match}"
        end
      else
        raise "🛑 Could not find 'project(lib3mf ...)' to patch CMakeLists.txt"
      end
    end

    # Comment out test subdirectory to avoid missing files
    contents.gsub!(/^\s*add_subdirectory\s*\(\s*Tests\s*\)/, "# add_subdirectory(Tests) DISABLED BY HOMEBREW")

    File.write(cmake_file, contents)

    mkdir "build" do
      system "cmake", "..",
                      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                      "-DBUILD_TESTING=OFF",
                      "-DCMAKE_INSTALL_LIBDIR=lib",
                      *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_predicate include/"Lib3MF/Version.h", :exist?
  end
end

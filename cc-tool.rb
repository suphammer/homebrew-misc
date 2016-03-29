require 'formula'

class CcTool < Formula
  homepage 'https://github.com/suphammer/cc-tool'
  url 'https://github.com/suphammer/cc-tool.git'

  depends_on 'libusb'
  depends_on 'boost'
  depends_on 'pkg-config' => :build

  # Fix makefile
  patch :DATA

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

__END__
diff -uNr a/Makefile.in b/Makefile.in
--- a/Makefile.in
+++ b/Makefile.in
@@ -224,7 +224,7 @@
 LD = @LD@
 LDFLAGS = @LDFLAGS@
 LIBOBJS = @LIBOBJS@
-LIBS = -s \
+LIBS = \
 	$(BOOST_FILESYSTEM_LIBS) \
 	$(BOOST_REGEX_LIBS) \
 	$(BOOST_SYSTEM_LIBS) \

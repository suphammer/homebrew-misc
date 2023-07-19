class Gmtdisas < Formula
  desc "STM8 disassembler"
  homepage "https://github.com/volbus/gmtdisas"
  url "https://github.com/volbus/gmtdisas.git", branch: "main"
  version "head"
  sha256 ""
  license ""

  patch :DATA

  def install
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/gmtdisas.c b/gmtdisas.c
index 7d4cafc..00f4658 100644
--- a/gmtdisas.c
+++ b/gmtdisas.c
@@ -78,7 +78,7 @@ main (int argc, char **argv)
   }
 
   if (prog_mode & PROG_MODE_IONAME) {
-    FILE *iofile = fopen ("/usr/share/gmtdisas/stm8.inc", "r");
+    FILE *iofile = fopen ("/opt/homebrew/Cellar/gmtdisas/head/share/stm8.inc", "r");
     if (!iofile) {
       puts (strerror(errno));
       prog_mode &= ~PROG_MODE_IONAME;
diff --git a/makefile b/makefile
index c6a1d82..37f584b 100644
--- a/makefile
+++ b/makefile
@@ -6,9 +6,10 @@ all:
 	$(CC) $(CFLAGS) gmtdisas.c -o gmtdisas
 
 install:
-	cp -u gmtdisas /usr/local/bin/gmtdisas
-	-mkdir /usr/share/gmtdisas
-	cp -u stm8.inc /usr/share/gmtdisas/
+	-mkdir -p /opt/homebrew/Cellar/gmtdisas/head/bin
+	cp gmtdisas /opt/homebrew/Cellar/gmtdisas/head/bin/
+	-mkdir -p /opt/homebrew/Cellar/gmtdisas/head/share
+	cp stm8.inc /opt/homebrew/Cellar/gmtdisas/head/share/
 
 clean:
 	rm gmtdisas

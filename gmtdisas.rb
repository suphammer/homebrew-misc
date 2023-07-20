class Gmtdisas < Formula
  desc "STM8 disassembler"
  homepage "https://github.com/volbus/gmtdisas"
  url "https://github.com/volbus/gmtdisas.git", branch: "main"
  version "head"
  sha256 ""
  license ""

  patch :DATA

  def install
    system "make", "DESTDIR=#{prefix}"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/gmtdisas.c b/gmtdisas.c
index 7d4cafc..cf02e46 100644
--- a/gmtdisas.c
+++ b/gmtdisas.c
@@ -78,7 +78,7 @@ main (int argc, char **argv)
   }
 
   if (prog_mode & PROG_MODE_IONAME) {
-    FILE *iofile = fopen ("/usr/share/gmtdisas/stm8.inc", "r");
+    FILE *iofile = fopen (STM8_INC_PATH "/stm8.inc", "r");
     if (!iofile) {
       puts (strerror(errno));
       prog_mode &= ~PROG_MODE_IONAME;
diff --git a/ins.h b/ins.h
index ea73763..3716b5d 100644
--- a/ins.h
+++ b/ins.h
@@ -35,8 +35,8 @@ typedef struct {
 
 static const instruction ins_table[]={
     {"neg  ", SHORTOFF_SP_2, 0, 2},
-    {"rrwa ", REG_X, 0, 1},
-    {"rlwa ", REG_X, 0, 1},
+    {"rrwa ", REG_X, REG_A, 1},
+    {"rlwa ", REG_X, REG_A, 1},
     {"cpl  ", SHORTOFF_SP_2, 0, 2},
     {"sra  ", SHORTOFF_SP_2, 0, 2},
     {"void ", 0, 0, 0},
diff --git a/makefile b/makefile
index c6a1d82..7a940d0 100644
--- a/makefile
+++ b/makefile
@@ -1,14 +1,16 @@
-
-CFLAGS= -g -Wall -Werror -o2 -std=gnu99
+DEFAULT_DESTDIR = /usr/local
+DESTDIR ?= $(DEFAULT_DESTDIR)
+CFLAGS= -g -Wall -Werror -o2 -std=gnu99 -DSTM8_INC_PATH='"$(DESTDIR)/share"'
 CC= gcc
 
 all:
 	$(CC) $(CFLAGS) gmtdisas.c -o gmtdisas
 
 install:
-	cp -u gmtdisas /usr/local/bin/gmtdisas
-	-mkdir /usr/share/gmtdisas
-	cp -u stm8.inc /usr/share/gmtdisas/
+	mkdir -p $(DESTDIR)/bin
+	cp -p gmtdisas $(DESTDIR)/bin/
+	mkdir -p $(DESTDIR)/share
+	cp -p stm8.inc $(DESTDIR)/share/
 
 clean:
 	rm gmtdisas

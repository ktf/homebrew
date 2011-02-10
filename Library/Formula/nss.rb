require 'formula'

class Nss <Formula
  url 'https://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_12_6_RTM/src/nss-3.12.6.tar.gz'
  homepage 'www.mozilla.org'
  md5 'da42596665f226de5eb3ecfc1ec57cd1'

# depends_on 'cmake'
  depends_on 'berkeley-db'
  depends_on 'nspr'

  def patches
    DATA
  end
  
  def install
    conf = ["--prefix=#{prefix}", "--disable-debug", "--enable-strip", "--enable-optimize"]
    ENV["USE_64"] = "1" if Hardware.is_64_bit? and MACOS_VERSION >= 10.6
    ENV["NSPR_INCLUDE_DIR"] = "#{HOMEBREW_PREFIX}/include/nspr"
    ENV["NSPR_LIB_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "make -C ./mozilla/security/coreconf clean"
    system "make -C ./mozilla/security/dbm clean"
    system "make -C ./mozilla/security/nss clean"
    system "make -C ./mozilla/security/coreconf"    
    system "make -C ./mozilla/security/dbm"
    system "make -C ./mozilla/security/nss & true"
    system "make -C ./mozilla/security/nss & true"
    system "make -C ./mozilla/security/nss & true"
    system "make -C ./mozilla/security/nss & true"
    system "install -d #{prefix}/include/nss3"
    system "install -d #{prefix}/lib"
    system "find mozilla/dist/public/nss -name '*.h' -exec install -m 644 {} #{prefix}/include/nss3 \\;"
    system "find . -path '*/mozilla/dist/*.OBJ/lib/*.dylib' -exec install -m 755 {} #{prefix}/lib \\;"
    system "find . -path '*/mozilla/dist/*.OBJ/lib/*.so' -exec install -m 755 {} #{prefix}/lib \\;"
  end
end

__END__
diff --git a/mozilla/security/coreconf/nsinstall/Makefile b/mozilla/security/coreconf/nsinstall/Makefile
index c794890..a6efc28 100644
--- a/mozilla/security/coreconf/nsinstall/Makefile
+++ b/mozilla/security/coreconf/nsinstall/Makefile
@@ -69,6 +69,6 @@ include $(DEPTH)/coreconf/rules.mk
 
 # Redefine MAKE_OBJDIR for just this directory
 define MAKE_OBJDIR
-if test ! -d $(@D); then rm -rf $(@D); mkdir $(@D); fi
+if test ! -d $(@D); then rm -rf $(@D); mkdir -p $(@D); fi
 endef
 

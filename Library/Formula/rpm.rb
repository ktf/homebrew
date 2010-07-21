require 'formula'

class Rpm <Formula
  url 'http://rpm.org/releases/rpm-4.8.x/rpm-4.8.0.tar.bz2'
  homepage ''
  md5 '04b586910243cb2475ac16becd862731'

  depends_on 'nss'
  depends_on 'lua'
  depends_on 'magicfile'
  depends_on 'nspr'
  skip_clean 'bin'
  
  def patches
    system "rm -rf lib/rpmhash.*"
    patches = []
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-case-insensitive-sources.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-add-missing-__fxstat64.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-case-insensitive-fixes.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-fix-glob_pattern_p.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-remove-chroot-check.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-remove-strndup.patch?revision=1.1"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-allow-empty-buildroot.patch?revision=HEAD" 
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-fix-missing-libgen.patch?revision=HEAD"
    patches << "http://cmssw.cvs.cern.ch/cgi-bin/cmssw.cgi/COMP/CMSDIST/rpm-4.8.0-fix-find-provides.patch?revision=HEAD"
    patches
  end
  
  def install
    system <<EOF
      ./configure --disable-debug --disable-dependency-tracking --prefix="#{prefix}" \
                  --with-external-db --disable-python --disable-nls \
                  --disable-rpath --enable-sqlite3 \
                  CFLAGS="-ggdb -O0 -I#{HOMEBREW_PREFIX}/include -I#{HOMEBREW_PREFIX}/include/nspr -fnested-functions \
                          -I#{HOMEBREW_PREFIX}/include/nss3" \
                  LDFLAGS="-L#{HOMEBREW_PREFIX}/lib" \
                  CPPFLAGS="-I#{HOMEBREW_PREFIX}/include/nspr \
                            -I#{HOMEBREW_PREFIX}/include \
                            -I#{HOMEBREW_PREFIX}/include/nss3" \
                  LIBS="-lnspr4 -lnss3 -lnssutil3 -lplds4 -lplc4 \
                        -lz -lpopt -liconv -ldb"
EOF
#   system "cmake . #{std_cmake_parameters}"
    system "make install"
    system "perl -p -i -e 's|^.buildroot|#%%buildroot|' #{prefix}/lib/rpm/macros"
  end
end

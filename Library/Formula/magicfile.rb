require 'formula'

class Magicfile <Formula
  url 'ftp://ftp.fu-berlin.de/unix/tools/file/file-5.04.tar.gz'
  homepage ''
  md5 ''

# depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
#   system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end

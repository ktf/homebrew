require 'formula'

class Gazelle < Formula
  url 'http://gazelle.googlecode.com/files/gazelle-0.4.tar.gz'
  homepage 'http://www.reverberate.org/gazelle/'
  md5 'c1c2bab5a245664ee242696604bb9785'

  depends_on 'lua'

  # don't strip binaries
  skip_clean ['bin', 'lib']

  def install
    system "make utilities/srlua-glue LDFLAGS='-llua'"
    system "make utilities/srlua LDFLAGS='-llua'"    
    system "make LDFLAGS='-llua'"
    system "make install PREFIX=#{prefix}"
  end
end

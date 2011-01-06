require 'formula'

class KyotoCabinet <Formula
  url 'http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.33.tar.gz'
  homepage 'http://fallabs.com/kyotocabinet/'
  md5 '4f3df183c5d851056d1dec8e04baf54c'

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make" # Separate steps required
    system "make install"
  end
end

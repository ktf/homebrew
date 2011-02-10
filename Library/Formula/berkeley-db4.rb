require 'formula'

class BerkeleyDb4 <Formula
  @url='http://download.oracle.com/berkeley-db/db-4.5.20.tar.gz'
  @homepage='http://www.oracle.com/technology/products/berkeley-db/index.html'
  @md5='b0f1c777708cb8e9d37fb47e7ed3312d'

  def install
    # BerkeleyDB dislikes parallel builds
    ENV.deparallelize
    ENV.O3 # takes an hour or more with link time optimisation

    args = ["--disable-debug",
            "--prefix=#{prefix}", "--mandir=#{man}",
            "--enable-cxx"]
    args << "--enable-java" unless ARGV.include? "--without-java"

    # BerkeleyDB requires you to build everything from the build_unix subdirectory
    configure_args = "--disable-debug",  "--prefix=#{prefix}", "--mandir=#{man}"
    configure_args << "--enable-cxx" if ARGV.include? '--enable-cxx'
    configure_args << "--enable-java" if ARGV.include? '--enable-java'
    
    Dir.chdir 'build_unix' do
      system "../dist/configure", *configure_args
      system "make install"

      # use the standard docs location
      doc.parent.mkpath
      mv prefix+'docs', doc
    end
  end
end

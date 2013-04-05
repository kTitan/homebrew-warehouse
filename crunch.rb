require 'formula'

class Crunch < Formula
  homepage 'http://sourceforge.net/projects/crunch-wordlist/'
  url 'http://downloads.sourceforge.net/project/crunch-wordlist/crunch-wordlist/crunch-3.4.tgz'
  sha1 '2e73faa0f8f8a9a761c1f191e201d0be76f74491'

  def install
    # Replace Variables because there is no configure script
    inreplace 'Makefile' do |s|
      s.remove_make_var! %w[CFLAGS VCFLAGS LFS]
      s.change_make_var! "CC", ENV.cc
      s.change_make_var! "PREFIX", prefix
      s.change_make_var! "BINDIR", bin
      s.change_make_var! "MANDIR", man1
    end

    system "make"

    # Installing files directly is easier then patching the Makefile
    bin.install ['crunch']
    man1.install ['crunch.1']
    share.install ['charset.lst']
  end

  test do
    system "#{bin}/crunch"
  end
end

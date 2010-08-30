dep 'rsync' do
  requires 'rsync.src'
end

dep 'rsync.src' do
  requires 'build tools'
  provides '/usr/local/bin/rsync'
  prefix '/usr/local'
  source "http://www.samba.org/ftp/rsync/rsync-3.0.7.tar.gz"
  extra_source "http://www.samba.org/ftp/rsync/rsync-patches-3.0.7.tar.gz"
  preconfigure {
      log_shell "patching rsync", "patch -p1 <patches/fileflags.diff; patch -p1 <patches/crtimes.diff; ./prepare-source"
    end
  }
  after {
    log_shell "checking version:", "/usr/local/bin/rsync --version"
    in_dir '/usr/bin' do
      sudo "mv -v /usr/bin/rsync /usr/bin/rsync.apple"
      sudo "ln -sf /usr/local/bin/rsync /usr/bin/rsync"
      sudo "chmod 755 /usr/local/bin"
    end
    }
end
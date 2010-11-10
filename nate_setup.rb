# 100828
# 100915, moved rsync into this dep file
# mapping out new machine setup

dep 'nate_setup' do
  requires 'Telephone.app', 'textmate', 'CoRD.app', 'Cyberduck.app', 'Dropbox.app', 'SimpleText.app', 'IPSecuritas.app', 'Quicksilver.app', 'SelfControl.app', 'WriteRoom.app', 'Google Chrome.app', 'Sequel Pro.app', 'Firefox.app', 'rsync'
end

# app deps

dep 'Telephone.app' do
  source 'http://telephone.googlecode.com/files/Telephone-0.15.dmg'
end

dep 'textmate' do
  requires 'TextMate.app', 'textmate helper'
end

dep 'textmate helper' do
  requires 'TextMate.app'
  met? { which 'mate' }
  meet { shell "ln -sf '#{app_dir('TextMate.app') / 'Contents/SharedSupport/Support/bin/mate'}' /usr/local/bin/mate" }
end

dep 'TextMate.app' do
  source 'http://download-b.macromates.com/TextMate_1.5.9.dmg'
end

dep 'CoRD.app' do
  # use repackaged version here
  source 'http://nate.adullmoment.com/pkg/cord.dmg'
end

dep 'Cyberduck.app' do
  source "http://cyberduck.ch/Cyberduck-3.7.zip"
end

dep 'Dropbox.app' do
  source "http://cdn.dropbox.com/Dropbox%200.7.110.dmg"
end

dep 'SimpleText.app' do
  source "http://simpletext.s3.amazonaws.com/SimpleText.dmg"
end

dep 'IPSecuritas.app' do
  source 'http://www.lobotomo.com/products/downloads/IPSecuritas.dmg'
end

dep 'VirtualBox.app' do
  source 'http://dlc.sun.com.edgesuite.net/virtualbox/3.2.8/VirtualBox-3.2.8-64453-OSX.dmg'
end

dep 'Quicksilver.app' do
  source 'http://blacktree.meadgroup.com/quicksilver/application/QS.3815.dmg'
end

dep 'SelfControl.app' do
  source 'http://cloud.github.com/downloads/slambert/selfcontrol/SelfControl-1.2.2.zip'
end

dep 'WriteRoom.app' do
  source 'http://writeroom.s3.amazonaws.com/WriteRoom.dmg'
end

dep 'Firefox.app' do
  source 'http://nate.adullmoment.com/pkg/Firefox3.6.8.dmg'
end

dep 'Google Chrome.app' do
  source 'http://dl.google.com/chrome/mac/beta/GoogleChrome.dmg'
end

#dep "Remote Desktop.app" do
#  source 'http://nate.adullmoment.com/pkg/ARD3.dmg.zip'
#end

dep 'Sequel Pro.app' do
  source 'http://sequel-pro.googlecode.com/files/sequel-pro-0.9.8.1.dmg'
end


# rubygems

dep 'twt.gem' do
  met? { which 'twt' }
end

dep 'redcloth.gem'

dep 'facter.gem' do
  met? { which 'facter' }
end

dep 'puppet.gem' do
  met? { which 'puppet'}
end

dep 'capistrano.gem' do
  met? { which 'cap'}
end

#dep 'zonefile.gem' do
#end

dep 'slideshow.gem' do
end


# source
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
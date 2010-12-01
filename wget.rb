dep 'wget.src' do
  requires 'build tools'
  provides '/usr/local/bin/wget'
  prefix '/usr/local'
  source "ftp://ftp.gnu.org/gnu/wget/wget-latest.tar.gz"
  after {
    log_shell "checking version:", "/usr/local/bin/wget --version"
    }
end
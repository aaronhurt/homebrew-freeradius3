require "formula"

class FreeradiusServer3 < Formula
  homepage "http://freeradius.org/"
  url "ftp://ftp.freeradius.org/pub/freeradius/freeradius-server-3.0.4.tar.gz"
  sha256 "56919b25d5b2ff301cb37278494498f35d8c58986c33d693d6c0cd757a4a1fe9"
  sha1 "16069ab9ceccfb5fc6a2710ea24fac99d96e42e8"

  # needs talloc and openssl
  depends_on "talloc"
  depends_on "openssl"

  # optional depends for modules
  depends_on "mysql"        => :optional # rlm_sql
  depends_on "postgresql"   => :optional # rlm_sql
  depends_on "sqlite"       => :optional # rlm_sql
  depends_on "unixodbc"     => :optional # rlm_sql
  depends_on "freetds"      => :optional # rlm_sql
  depends_on "gdbm"         => :optional # rlm_ippool
  depends_on "json-c"       => :optional # rlm_rest
  depends_on "redis"        => :optional # rlm_redis, rlm_rediswho
  depends_on "ykclient"     => :optional # rlm_yubikey
  depends_on "libcouchbase" => :optional # rlm_couchbase

  head do
    url "https://github.com/FreeRADIUS/freeradius-server.git", :using => :git, :branch => "master"
  end

  devel do
    url "https://github.com/FreeRADIUS/freeradius-server.git", :using => :git, :branch => "v3.0.x"
  end

  def install
    ENV.deparallelize

    args = %W[
      --prefix=#{prefix}
      --without-rlm_eap_ikev2
      --without-rlm_eap_tnc
      --without-rlm_sql_db2
      --without-rlm_sql_firebird
      --without-rlm_sql_iodbc
      --without-rlm_sql_oracle
      --without-rlm_securid
    ]

    args << "--enable-developer" if !build.stable?

    system "./configure", *args
    system "make"
    system "make install"
  end
end

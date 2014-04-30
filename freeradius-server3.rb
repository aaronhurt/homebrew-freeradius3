require 'formula'

class FreeradiusServer3 < Formula
  homepage 'http://freeradius.org/'
  url 'ftp://ftp.freeradius.org/pub/freeradius/freeradius-server-3.0.2.tar.gz'
  sha1 '27e908e245470e96e5a5fea0f00c09901b0d7fb5'

  # needs talloc and openssl
  depends_on 'talloc'
  depends_on 'openssl'

  # optional depends for modules
  depends_on 'mysql'      => :optional # rlm_sql
  depends_on 'postgresql' => :optional # rlm_sql
  depends_on 'sqlite'     => :optional # rlm_sql
  depends_on 'unixodbc'   => :optional # rlm_sql
  depends_on 'freetds'    => :optional # rlm_sql
  depends_on 'gdbm'       => :optional # rlm_ippool
  depends_on 'json-c'     => :optional # rlm_rest
  depends_on 'redis'      => :optional # rlm_redis, rlm_rediswho
  depends_on 'ykclient'   => :optional # rlm_yubikey

  def install
    ENV.deparallelize

    system "./configure", "--prefix=#{prefix}",
                          "--without-rlm_eap_ikev2",
                          "--without-rlm_eap_tnc",
                          "--without-rlm_sql_db2",
                          "--without-rlm_sql_firebird",
                          "--without-rlm_sql_iodbc",
                          "--without-rlm_sql_oracle",
                          "--without-rlm_securid"
    system "make"
    system "make install"
  end
end


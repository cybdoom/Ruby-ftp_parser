require 'net/ftp'

class Parser
  DEFAULT_HOSTNAME = 'localhost'
  DEFAULT_PORT = 12345

  def initialize(hostname=DEFAULT_HOSTNAME, port=DEFAULT_PORT)
    @ftp_client = Net::FTP.new
    @ftp_client.connect hostname, port
    @ftp_client.login
  end

  def stats_for_user user_index
    @ftp_client.chdir "user#{user_index}"
    @ftp_client.chdir 'playlists'

  end
end

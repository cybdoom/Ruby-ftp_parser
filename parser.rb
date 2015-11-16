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
    @user_index = user_index
    @ftp_client.chdir File.join('root', "user#{@user_index}", 'playlists')
    @meta_info = {}
    @sizes = {}
    begin
      @ftp_client.gettextfile('playlists.txt') do |line|
        name, size = line.split(' ').flatten
        @meta_info[name] = size.to_i
        @sizes[name] = 0
      end
    rescue Exception => e
      puts 'Error while reading playlists meta info'
      exit 2
    end
    get_sizes
    generate_stats
  end

  private

  def get_sizes
    @sizes = {}
    @ftp_client.list.each do |str|
      next unless str =~ /\Ad/
      chunks = str.split(' ')
      @sizes[chunks.last] = chunks[4].to_i
    end
  end

  def generate_stats
    @stats = {}
    puts @meta_info
    @sizes.each {|name, size| @stats[name] = (size * 100.to_f/@meta_info[name]).round(2) }
    @stats = {
      "user#{@user_index}" => @stats
    }
  end
end

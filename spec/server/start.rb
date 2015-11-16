require 'ftpd'
require 'tmpdir'

class Driver
  def authenticate(user, password)
    true
  end

  def file_system(user)
    Ftpd::DiskFileSystem.new '/'
  end
end

driver = Driver.new
server = Ftpd::FtpServer.new(driver)
server.port = 12345
server.start
puts "Server listening on port #{server.bound_port}"
gets

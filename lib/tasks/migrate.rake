require 'lib/stored_file'

desc "Updates database structure to reflect program assertions"
task :migrate do
  DataMapper.auto_upgrade!  
  puts "Migration succesful!"
end

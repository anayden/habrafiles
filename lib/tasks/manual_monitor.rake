require 'ftools'
require 'lib/stored_file'

desc "Checks directory 'manual' and uploads all files from it"
task :manual_monitor do
  Dir["manual/*"].each do |path|
    file = File.new(path)
    filename = File.basename(file.path)
    digest = Digest::SHA1.hexdigest(filename)
    stored_file = StoredFile.create :filename => filename, :sha => digest, :filesize => File.size(file.path)
    File.move(path, "./files/#{stored_file.id}.upload")
    puts "File #{path} succesfully uploaded. ID = #{stored_file.id}"
  end
end
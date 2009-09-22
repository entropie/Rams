#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ams"

include Rams::Database::Tables
task :a do
  u = User.all.each{|u|
    p u.name
    p u.agency.name
  }
end


task :start do
  sh "cd app && ruby start.rb"
end


task :clean do
  require "find"
  Find.find(File.join(Dir.pwd)) do |file|
    if File.basename(file) == ".DS_Store"
      File.unlink file 
      puts file
    end
  end
end


require "dbhelper"

task :deploy => [:umigrate, :migrate, :db_fill] do
end

task :db_fill do
  ruby "script/db_migration_devel.rb"
end

task :migrate do
  Rams::Database.migrate
end

task :umigrate do
  Rams::Database.migrate(:down)
end


task :pptables do
  Rams::Database.definitions.each do |tbl|
    puts
    puts tbl.name
    puts
    tbl.print
  end
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end

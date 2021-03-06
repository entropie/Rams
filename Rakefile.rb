#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ams"

include Rams::Database::Tables
task :a do
  p User.first.agency.users
end

task :todo do
  files = Hash.new{|h,k| h[k] = []}
  Dir.glob('{lib,app}/**/*.rb') do |file|
    lastline = todo = comment = long_comment = false
 
    File.readlines(file).each_with_index do |line, lineno|
      lineno += 1
      comment = line =~ /^\s*?#.*?$/
      long_comment = line =~ /^=begin/
      long_comment = line =~ /^=end/
      todo = true if line =~ /TODO|FIXME|THINK/ and (long_comment or comment)
      todo = false if line.gsub('#', '').strip.empty?
      todo = false unless comment or long_comment
      if todo
        l = line.strip.gsub(/^#\s*/, '')
        str = ''
        str << l
        lastline = lineno
        files[file] << ("#{lineno}\t" << str)
      end
    end
  end
  File.open('FIXMES', 'w+'){|f|
    files.each_pair{|fk, fv|
      f.puts(fk)
      fv.each do |fline|
        f.puts "  #{fline}"
      end
      f.puts
    }
  }
end

task :start do
  sh "cd app && ruby start.rb"
end

task :todofile => [:todo] do
  todos = User.first.todo.select{|t| t.category == "DEVEL"}
  str = "# File is Autogenerated at #{Time.now.to_s(false)}\n\n"
  todos.each do |t|
    mark = t.done == 1 ? "-" : '*'
    str << "#{mark} [#{t.created_at.to_s(false)}]\n  #{t.body}\n"
  end
  File.open("TODO", File::WRONLY|File::TRUNC|File::CREAT){|f| f.write(str)}
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

task :deploy => [:umigrate, :migrate, :todo, :db_fill, :todofile] do
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

#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

task :clean do
  require "find"
  Find.find(File.join(Dir.pwd)) do |file|
    if File.basename(file) == ".DS_Store"
      File.unlink file 
      puts file
    end
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

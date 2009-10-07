#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require 'net/sftp'
require "lib/ams"

ramaze_hash = "5dda528952206cb2b5943d65ab7427e692482881"
task :get_ramaze do
  run "cd /u/apps && rm -rf ramaze"
  run "cd /u/apps/ && git clone git://github.com/manveru/ramaze.git; cd ramaze && git checkout -b deploy #{ramaze_hash}"
end


after "deploy:symlink" do
  tf = "#{current_path}/.mysql.pw"
  run "touch  #{tf}"
  put(File.readlines(File.join(Rams::Source, ".mysql.pw")).join, tf)
end


task :start do
  run "cd #{current_path} && screen -d -m -S ams -- rake start"
end
task :stop do
  run "screen -r ams -X kill; killall -9 ruby"
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end

#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#
jobhash = {:name => "Ein Beispiel-Job", :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}

def gtimes
  mod = (s=rand(10)+1)*3600*24
  {
    :start_time => (a=Time.now)-mod,
    :end_time   => a+mod,
  }
end

u = User.first
location = u.agency.locations.first

1.upto(15) do |i|
  
  mods = []

  mtimes = Rams::Database::Tables::job_modules(:time)
  mods << mtimes.create(gtimes)

  if i % 2 == 0
    mlocs =  Rams::Database::Tables::job_modules(:location)
    mlocs = mlocs.create(:fixed => 1)
    mlocs.add_location(location)
    mods << mlocs
  end

  if rand(2) == 1
    mpgs =  Rams::Database::Tables::job_modules(:products)
    mpgs = mpgs.create
    pg = u.agency.product_groups.first
    mpgs.add_product_group(pg)
    mods << mpgs
  end

  job = u.setup_job(jobhash.dup.update(:name => "#{jobhash[:name]} #{i}"), mods)
end
=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end

#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


def jobhash
  a={
    :name => Faker::Lorem.words(1+rand(2)+rand(2)).join(" "),
    :description => Faker::Lorem.paragraph(3),
  }
  a
end
def gtimes
  mod = (s=rand(10)+1)*3600*24
  {
    :start_time => (a=Time.now)-mod,
    :end_time   => a+mod,
    :kind       => jid_type = rand(3)
  }
end

u = User[2]
location = u.agency.locations[1]

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
    0.upto(rand(20)+1) do |j|
      begin
        pg = u.agency.product_groups.select{|k| k.id == j}.first
        mpgs.add_product_group(pg) if pg
      rescue
        p $!
      end
    end
    mods << mpgs
  end

  job = u.setup_job(jobhash, mods)
end
=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end

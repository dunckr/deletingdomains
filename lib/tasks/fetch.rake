require 'net/http'
require 'multi_json'
require 'csv'

desc "seed the database"
task :fetch => :environment do
  # download
  # inmemory
  # sort
  # add to db

  data = open
  domains = []

  CSV.foreach(data, :converters => :all) do |row|

    path = row[0].split '.'

    if path[1] == 'com' and path[0] =~ /^[a-z]+$/ and path[0].length < 6

      domains << {
        'name' => path[0],
        'tld' => path[1],
        'expiry' => row[1],
        'rating' => 0
      }
    end
  end


  domains.each do |domain|
    puts "#{domain['name']} #{domain['tld']}"
  end
  puts domains.count
end

def download
  # "http://pool.com/Downloads/PoolDeletingDomainsList.zip"
end

def open
  # File.open("#{Rails.root}/lib/assets/PoolDeletingDomainsList.txt").read
  # File.open("#{Rails.root}/lib/assets/PoolDeletingDomainsList.txt")
  File.open("#{Rails.root}/lib/assets/old.txt")
end

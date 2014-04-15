require 'csv'
require 'zipruby'
require 'net/http'

desc "seed the database"
task :fetch => :environment do
  unzipped = unzip download
  domains = parse unzipped
  populate domains
end

def parse(data)
  domains = []
  CSV.foreach(data.read, :converters => :all) do |row|
    domain = row[0].split '.'
    if acceptable domain
      domains << {
        'name' => path[0],
        'tld' => path[1],
        'expiry' => row[1]
      }
    end
  end
  domains
end

def acceptable(domain) 
  domain[1] == 'com' and domain[0] =~ /^[a-z]+$/ and domain[0].length < 6
end

def populate(domains)
  domains.each do |domain|
    insert domain
  end
end

def insert(item)
  ActiveRecord::Base.connection.execute("INSERT INTO domains (name, tld, expiry) VALUES ('" \
    + item['name'].to_s + "','" \
    + item['tld'].to_s + "','" \
    + item['expiry'].to_s + "')"
  )
end

def unzip(source)
  Zip::Archive.open_buffer(source) do |archive|
    archive.fopen(archive.get_name(0)) do |file|      
      return file.read
    end
  end
end

def download
  Net::HTTP.get(URI.parse(url))
end

def url
  "http://pool.com/Downloads/PoolDeletingDomainsList.zip"
end

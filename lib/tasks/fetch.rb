require 'net/http'
require 'multi_json'

desc "seed the database"
task :fetch => :environment do
  # download
  # inmemory
  # sort
  # add to db
end

def download
  "http://pool.com/Downloads/PoolDeletingDomainsList.zip"
end

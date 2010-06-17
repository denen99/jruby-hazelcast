require 'yaml'
require 'erb'

file = 'test.yml' 
environment = 'production'

   conf = YAML::load(ERB.new(IO.read(file)).result)[environment]


   conf.each do |key,value|
        puts "KEY: " + key + " VALUE: " + value  
   end unless conf.nil?

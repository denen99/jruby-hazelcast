require 'java'
require 'rubygems'
require 'jruby-hazelcast'

key = rand
value = rand 

c = HazelcastCacheClient.instance
c.put(key,value)

resp = c.get(key)

if resp == value 
  puts "READ / WRITE WORKS !!"
else
  puts "Something went wrong !!"
end

c.client.shutdown

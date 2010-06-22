#--
# Copyright (c) 2010 Adam Denenberg
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

  require 'java'
  require 'lib/hazelcast-client-1.8.4.jar'
  require 'singleton'
  require 'yaml'
  require 'erb'

  import com.hazelcast.client.HazelcastClient;
  import java.util.Map;

  class HazelcastCacheClient
      
      include Singleton
      attr_accessor :client, :map, :app_root, :hostname, :username, :password

      class CacheException  < StandardError; end

      def initialize
        @hostname = 'localhost' 
        @username = 'dev' 
        @password = 'dev-pass'
        @mapname = 'default'
        parse_options
        @client = HazelcastClient.newHazelcastClient(@username, @password, @hostname);
        @map  = @client.getMap(@mapname);
      end

      def parse_options(app_root = Dir.pwd)
         if defined?(RAILS_ROOT)
           self.app_root = RAILS_ROOT + '/config/' 
           environment = RAILS_ENV || 'production'
         else
           self.app_root = app_root 
           environment = ENV['JRUBY_HAZELCAST_ENV'] || 'production'
         end

         config_file = self.app_root + '/hazelcast.yml'
         if !File.exists?(config_file) 
           return puts "hazelcast.yml missing in directory " + self.app_root + ' , using defaults !!!' 
           return false 
         end
     
         conf = YAML::load(ERB.new(IO.read(config_file)).result)[environment]
         return if conf.nil? 
  
         conf.each do |key,value|
          case key 
           when 'hostname'
            @hostname = value 
           when 'username'
            @username = value 
           when 'password'
            @password = value 
           when 'mapname'
            @mapname = value 
          end unless conf.nil? 

         end

     end

     def keys
      @map.keys
     end

     def write(k,v)
        return unless k && v 
        @map.put(k,v)
     end

     def read(k)
       return unless k 
       @map.get(k)
     end

 end  #class HazelcastCache

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

require 'rubygems'
require 'active_support'

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if defined?(JRUBY_VERSION)
  require 'java'
  require 'lib/hazelcast-client-1.8.4.jar'
#  import com.hazelcast.core.Hazelcast;
  import com.hazelcast.client.HazelcastClient;
  import java.util.Map;
end

module ActiveSupport

  module Cache

    class HazelcastCacheStore < Store
      
      attr_accessor :app_root, :hostname, :username, :password

      class << self; attr_accessor :instance; end
      class CacheException  < StandardError; end

      private_class_method :new

      def HazelcastCacheStore.getInstance
        self.instance ||= new 
      end

      def initialize
        @hostname = 'localhost' 
        @username = 'dev' 
        @password = 'dev-pass'
        @mapname = 'default'
        @options = parse_options
        @client = HazelcastClient.newHazelcastClient(@username, @password, @host);
        @map  = @client.getMap(@mapname);
      end

      def parse_options(app_root = Dir.pwd)
         self.app_root = RAILS_ROOT + '/config/' if RAILS_ROOT 
         self.app_root = app_root 
         config_file = self.app_root + '/hazelcast.yml'

         raise("Sorry, hazelcast.yml missing in application root ") if !File.exists?(config_file) 
     
         conf = YAML::load(ERB.new(IO.read(path)).result)[environment]
  
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

    end  #class HazelcastCacheSTore

  end #module Cache

end #Module ActiveSupport



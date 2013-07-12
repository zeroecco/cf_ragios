# This plugin is to monitor login in and out of your cloudfoundry instance.
# It will test basic authentication against the cloudfoundry v1 API. 

require 'cloudfoundry'

module Monitors

class Afauth

    attr_reader :endpoint
    attr_accessor :describe_test_result
    attr_accessor :test_result

    def init(options)
      @user = ENV['username']
      @pass = ENV['password']
      @API_E = ENV['API_E']
      raise "A username and passwod must be specified for this plugin." if @user.nil? || @pass.nil?
      @describe_test_result = "Login to AppFog as  " + @user
    end

    def test_command
      begin

        cf_client = CloudFoundry::Client.new({:target_url => "#{@API_E}"})
        cf_client.login("#{@user}", "#{@pass}")
        @test_result = 'PASSED'
        return TRUE

      rescue Exception

        @test_result = $!
        return FALSE
      end
    end
end

end

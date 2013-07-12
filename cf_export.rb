require 'appfog_api'

module Monitors
  
class Afservices

    attr_reader :endpoint
    attr_accessor :describe_test_result 
    attr_accessor :test_result      

    def init(options)
      @user = ENV['username']
      @pass = ENV['password']
      raise "A username must be specified in ENV['username']for this plugin." if @user.nil?
      raise "A passwod must be specified in ENV['password']for this plugin." if @pass.nil?
      @describe_test_result = "Collect available servies to for " + @user 
    end
 
    def test_command
      begin

        api = API.new(@user, @pass)
        api.services
        @test_result = 'PASSED'
        return TRUE

      rescue Exception

        @test_result = $!
        return FALSE
      end    
    end
end

end    

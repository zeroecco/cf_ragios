require 'cloudfoundry'

module Monitors

class Afservices

    attr_reader :endpoint
    attr_accessor :describe_test_result
    attr_accessor :test_result

    def init(options)
      @user = ENV['username']
      @pass = ENV['password']
      @service = ENV['service']
      @app = ENV['app']
      raise "A username and passwod must be specified for this plugin." if @user.nil? || @pass.nil?
      @describe_test_result = "Collect available servies to for " + @service + " test bind, unbind for service"
    end

    def test_command
      begin

        cf_client = CloudFoundry::Client.new({:target_url => "https://api.appfog.com"})
        cf_client.login("#{@user}", "#{@pass}")
        cf_client.list_services()
        cf_client.create_service("redis", "#{@service}")
        cf_client.service_info("#{@service}")
        cf_client.bind_service("#{@service}", "#{@app}")
        cf_client.unbind_service("#{@service}", "#{@app}")
        cf_client.delete_service("#{@service}")

        @test_result = 'PASSED'
        return TRUE

      rescue Exception

        @test_result = $!
        return FALSE
      end
    end
end

end

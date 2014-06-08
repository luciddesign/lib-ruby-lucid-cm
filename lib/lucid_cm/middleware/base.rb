module LucidCM::Middleware
  class Base < LucidClient::Middleware::Base

    def log_key
      'Campaign Monitor'
    end

  end
end

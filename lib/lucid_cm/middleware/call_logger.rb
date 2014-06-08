module LucidCM::Middleware
  class CallLogger < LucidClient::Middleware::CallLogger

    def log_key
      'Campaign Monitor'
    end

  end
end

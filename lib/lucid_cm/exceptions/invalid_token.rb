module LucidCM::Exceptions
  class InvalidToken < StandardError

    def initialize( code )
      @code = code
    end

    def code
      @code
    end

    def to_s
      "Campaign Monitor rejected the token (#{code})"
    end

  end
end

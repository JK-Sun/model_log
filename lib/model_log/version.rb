module ModelLog
  module VERSION
    MAJOR = 2
    MINOR = 0
    TINY  = 1

    # Set PRE to nil unless it's a pre-release (beta, rc, etc.)
    PRE = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".").freeze

    def self.to_s
      STRING
    end
  end
end

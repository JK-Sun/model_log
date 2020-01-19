module ModelLog
  class Context
    def initialize(context)
      @context = context
    end

    def to_struct
      Struct.new(*@context.keys).new(*@context.values)
    end
  end
end

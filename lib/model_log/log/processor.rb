module ModelLog
  module Log
    class Processor
      include Initializer

      def data
        case action
        when :create
          created_data
        when :update
          updated_data
        when :destroy
          destroyed_data
        end
      end

      private

      def saved_data
        changes
      end

      alias_method :created_data, :saved_data
      alias_method :updated_data, :saved_data

      def destroyed_data
        data = attributes
        data = data.merge(changed_attributes) if changd?
        data.map { |attr, value| [attr, [value, nil]] }.to_h
      end
    end
  end
end

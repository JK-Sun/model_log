module ModelLog
  module Log
    class Processor
      include Base

      def data
        case @action
        when :create
          created_data
        when :destory
          destroyed_data
        when :update
          updated_data
        else
          raise StandardError, "invalid action given #{@action}"
        end
      end

      private

      def default_data
        @resource.changes
      end

      def created_data
        # key => value
        @resource.class.content_columns.map do |column|
          [column.name, @resource.send(column.name)]
        end.to_h
      end

      alias_method :destroyed_data, :created_data

      def updated_data
        # key => [before, after]
        default_data
      end
    end
  end
end

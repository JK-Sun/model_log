module ModelLog
  module Log
    class Processor < Base
      def data
        case @action
        when :create
          created_data
        when :destory
          destroyed_data
        when :update
          updated_data
        else
          default_data
        end
      rescue
        default_data
      end

      private

      def default_data
        @resource.changes
      end

      def created_data
        # TODO process data
        # key => value
        @resource.class.content_columns.map do |column|
          [column.name, @resource.send(column.name)]
        end.to_h
      end

      alias_method :destroyed_data, :created_data

      def updated_data
        # TODO process data
        # key => [before, after]
        default_data
      end
    end
  end
end

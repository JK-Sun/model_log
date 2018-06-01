module ModelLog
  module ClassMethods
    module Models
      def self.included(base)
        base.extend Invoking
      end

      module Invoking
        def model_log
          after_create :model_log_create
          after_destroy :model_log_destroy
          before_update :model_log_update
        end
      end

      private

        def model_log_create
          write_log(self, :create)
        end

        def model_log_update
          write_log(self, :update)
        end

        def model_log_destroy
          write_log(self, :destroy)
        end

        def data_processing(field_name, field_data, **options)
          if defined? CarrierWave::Uploader::Base and field_data.is_a? CarrierWave::Uploader::Base
            return options[:index] == 0 ? get_uploader_filename(field_data.url) : send("#{field_name}_identifier")
          elsif field_data.is_a? BigDecimal
            return field_data.to_f
          else
            return field_data
          end
        end

        def get_uploader_filename(path)
          if path
            rindex = path.rindex('/')
            return path.slice(rindex+1, path.size-rindex-1)
          end
          return nil
        end

        def write_log(resource, type)
          begin
            passport = ModelLog::Passport.current_passport
            request = ModelLog::Request.current_request
            type = type.to_s
            can_write = true
            content_text = {}

            if type == "update"
              changes = resource.changes
              changes.each do |key, values|
                value_arr = []
                values.each_with_index do |value, i|
                  value_arr << data_processing(key, value, :index => i)
                end
                content_text.merge!(Hash[key, value_arr])
              end

              can_write = false if content_text.empty?
            else
              resource.class.content_columns.each do |column|
                column_name = column.name
                column_val = data_processing(column_name, resource.send(column_name))
                content_text.merge!(Hash[column_name, column_val])
              end
            end

            file_content = <<-EFO.strip_heredoc.gsub("\n", "\t")
              #{request.try(:request_method)}
              #{request.try(:url)}
              #{request.try(:referer)}
              #{request.try(:remote_ip)}
              #{request.try(:user_agent)}
              #{ModelLog.platform}
              #{passport.try(:id)}
              #{passport.try(ModelLog.user_name_field)}
              #{type.to_s}
              #{resource.class}
              #{resource.id}
              #{Time.now}
              #{content_text}
            EFO

            ModelLog.info file_content if can_write
          rescue => e
            ModelLog.info e.message
          end
        end
    end
  end
end

ActiveRecord::Base.send(:include, ModelLog::ClassMethods::Models) if defined? ActiveRecord::Base


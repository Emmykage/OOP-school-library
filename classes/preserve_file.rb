require 'json'

class PreserveFile
  def initialize(file_store)
    @file_store = file_store
  end

  def save_to_json(data, options: {})
    file = File.new(file_store, 'w')
    file.write(JSON.generate(data, options))
    file.close
    'success'
  end

  def read_json(options: {})
    return [] unless File.exist?(@file_store)

    file = File.new(@file_store, 'r')
    file_data = JSON.parse(file.read, options)
    file.close
    file_data
  rescue StandardError
    puts "No file found to read on #{@file_store}"
    nil
  end
end

require_relative 'collector'
require_relative 'outparser'
require_relative 'parser_to_url'
require_relative 'persist/json_persist'
require_relative 'persist/csv_persist'
require 'pry'

class Solution

  TYPE_FILE = {
      'json' => JsonPersist,
      'csv' => CsvPersist
  }.freeze

  attr_reader :type_file, :params

  def initialize
    @params = Outparser.new.call
    @type_file = params.delete(:type)
  end

  def run
    handler.new(data).persist
  end

  private

  def handler
    TYPE_FILE[type_file]
  end

  def data
    Collector.new(array_urls).call
  end

  def array_urls
    ParserToUrl.new(params).call
  end
end

Solution.new.run

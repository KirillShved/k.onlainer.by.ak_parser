require_relative 'base'
require 'csv'

class CsvPersist < Base

  attr_reader :hash

  def initialize(hash)
    @hash = hash
  end

  def persist
    CSV.open('../storage/output.csv', 'w+', headers: hash.first.keys) do |csv|
      hash.each do |h|
        csv << h.values
      end
    end
  end
end



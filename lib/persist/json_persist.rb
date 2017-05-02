require_relative 'base'
require 'json'

class JsonPersist < Base

  attr_reader :hash

  def initialize(hash)
    @hash = hash
  end

  def persist
    File.open('../storage/result.json', 'w+').write(hash_to_json)
  end

  private

  def hash_to_json
    hash.to_json
  end
end

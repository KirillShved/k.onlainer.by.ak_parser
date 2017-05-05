require_relative 'base'
require 'pry'
require 'json'

class JsonPersist < Base

  attr_reader :hash, :path

  def initialize(hash, path = 'storage/result.json')
    @hash = hash
    @path = path
  end

  def persist
    file = File.open(path, 'w+')
    file.write(hash_to_json)
    file.flush
  end

  private

  def hash_to_json
    hash.to_json
  end
end

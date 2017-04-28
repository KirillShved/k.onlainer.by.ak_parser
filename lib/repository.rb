require_relative 'solution'

class Repository

  attr_reader :hash, :type_file

  # all_flat_info = {
  #     price_byn:  '',
  #     price_usd: '',
  #     flat: '',
  #     owner: '',
  #     phone_number: '',
  #     owner_name: '',
  #     apartment_info_text: '',
  #     apartment_address: '',
  #     enabled_elements: '',
  #     disabled_elements: ''
  # }

  def initialize(hash = {})
    @hash = hash
  end

  def call
    save_file
  end

  def save_file
    File.open("../storage/output.#{@type_file}", 'w+').write(hash_to_json)
  end

  def self.type_file(hash = {})
    @type_file ||= hash[:type]
  end

  def hash_to_json
    hash.to_json
  end

  def hash_to_csv
    hash
  end
end

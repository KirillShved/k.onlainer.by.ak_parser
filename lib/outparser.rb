require 'optparse'
require 'pry'

class Outparser
  DEFAULT_OPTIONS = {
    rent_type: [
      'room',
      '1_room',
      '2_rooms',
      '3_rooms',
      '4_rooms',
      '5_rooms',
      '6_rooms'
    ],
    currency: 'USD',
    price: {
      min: 50,
      max: 8500
    },
    only_owner: '',
    metro: [
      'red_line',
      'blue_line'
    ],
    bounds: {
      lb: {
        lat: 53.6764594639449,
        long: 27.365152809086844
      },
      rt: {
        lat: 54.12722002680655,
        long: 27.759527091732025
      }
    },
    page: 1,
    type: 'json'
  }.freeze

  attr_reader :options, :parser

  def initialize
    @options = DEFAULT_OPTIONS.dup
  end

  def call
    rooms
    min_price
    max_price
    metro
    owner
    type
    help
    parser.parse!
    options
  end

  private

  def parser
    @parser ||= OptionParser.new
  end

  def rooms
    parser.on('-r room,rooms', '--rooms rooms', Array) do |rooms|
      options[:rent_type] = rooms
    end
  end

  def min_price
    parser.on('--price_min 50', Integer) do |min_price|
      options[:price][:min] = min_price
    end
  end

  def max_price
    parser.on('--price_max 8500', Integer) do |max_price|
      options[:price][:max] = max_price
    end
  end

  def metro
    parser.on('-m red_line', '--metro red_line', Array) do |lines|
      options[:metro] = lines
    end
  end

  def owner
    parser.on('-o', '--owner') do |owner|
      options[:only_owner] = owner
    end
  end

  def type
    parser.on('-t TYPE', '--type TYPE', String,
              'Enter type of file(JSON or CSV).') do |type|
      options[:type] = type
    end
  end

  def help
    parser.on_tail('-h', '--help') do
      puts parser
      exit
    end
  end
end

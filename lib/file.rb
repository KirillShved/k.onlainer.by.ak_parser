require 'optparse'
require 'ostruct'

class OptparseExample

  def self.parse(args)
    options = OpenStruct.new

    # options.library = {
    #     rent_type: ['room', '1_room', '2_rooms', '3_rooms',
    #                 '4_rooms', '5_rooms', '6_rooms'],
    #     price:
    #         {
    #             min: 50,
    #             max: 8500
    #         },
    #     only_owner: false,
    #     metro:
    #         {
    #             red_line: false,
    #             blue_line: false
    #         },
    #     bounds:
    #         {
    #             Minsk:
    #                 {
    #                     lb:
    #                         {
    #                             lat: 53.6764594639449,
    #                             long: 27.365152809086844
    #                         },
    #                     rt:
    #                         {
    #                             lat: 54.12722002680655,
    #                             long: 27.759527091732025
    #                         }
    #                 },
    #
    #             Brest:
    #                 {
    #                     lb:
    #                         {
    #                             lat: 51.90969197851335,
    #                             long: 23.56046787023067
    #                         },
    #                     rt:
    #                         {
    #                             lat: 52.26596574508107,
    #                             long: 23.859347687036152
    #                         }
    #                 }
    #         }
    # }

    options.price_min = { min: 0 }
    options.price_max = { max: 0 }
    options.rooms = []
    options.file_type = :txt
    options.owner = false

    options.metro = { metro: { red_line: false, blue_line: false } }


    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: example.rb [options]'.freeze

      opts.separator ''.freeze
      opts.separator 'Specific options:'.freeze

      opts.on('-r room,rooms', '--rooms room,1_room,2_rooms', Array,
              'Enter number of rooms: room,1_room,2-6_rooms.') do |lib|
        options.rooms = lib
      end
      opts.on('--price_min 50', Integer, 'Enter the minimum price.') do |lib|
        options.price_min = { min: lib }
      end

      opts.on('--price_max 8500', Integer, 'Enter the maximum price.') do |lib|
        options.price_max = { max: lib }
      end

      opts.on('-o', '--owner', 'Owner') do |owner|
        options.owner = owner
      end

      opts.on('-t [TYPE]', '--type [TYPE]', [:text, :csv],
              'Choose the type of file to save: text or csv.') do |type|
        options.file_type = type
      end

      opts.separator ''.freeze
      opts.separator 'Common options:'.freeze

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
      options
  end
end

options = OptparseExample.parse(ARGV)
puts options
puts ARGV

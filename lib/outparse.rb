require_relative 'parser_to_url'

class Outparse
  options = {
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
      metro: ['red_line', 'blue_line'],
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
      page: 1
  }

  OptionParser.new do |opts|
    opts.on('-r room,rooms', '--rooms rooms', Array,
            'Enter number of rooms') do |rooms|
      options[:rent_type] = rooms
    end

    opts.on('-m red_line', '--metro red_line', Array,
            'Enter line of metro.') do |lines|
      options[:metro] = lines
    end

    opts.on('--price_min 50', Integer,
            'Enter the minimum price.') do |min_price|
      options[:price][:min] = min_price
    end

    opts.on('--price_max 8500', Integer,
            'Enter the maximum price.') do |max_price|
      options[:price][:max] = max_price
    end

    opts.on('-o', '--owner', 'Owner') do |owner|
      options[:only_owner] = owner
    end

    opts.on('-t TYPE', '--type TYPE', String) do |type|
      options[:file_type] = type
    end

    opts.on_tail('-h', '--help', 'Show this message') do
      puts opts
      exit
    end
  end.parse!

  ParserToUrl.new(options).call
end

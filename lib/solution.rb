require 'pry'
require 'active_support'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby example.rb [options]"

  opts.on("-f") do |v|
    options[:verbose] = v
  end
end.parse!

p options
p ARGV

# class Solution
#
#   attr_reader :sym, :price_max, :price_min, :page_number, :new_array, :hash
#
#
#
#   def initialize
#     @sym = 0
#     @price_max = 8500
#     @price_min = 50
#     @page_number = 1
#
#     @new_array = ARGV
#   end
#
#   def solve
#     puts @new_array
#   end
#
#   private
#
#   # def create_url
#   #
#   #   @onliner = "https://r.onliner.by/ak/?"
#   #   @price = "price%5Bmin%5D=#{@price_min}&price%5Bmax%5D=#{@price_max}&"
#   #   @currency = "currency=usd&bounds%5Blb%5D%5Blat%5D=50.92791578956747&bounds%5Blb%5D%5Blong%5D=23.19425039583162&bounds%5Brt%5D%5Blat%5D=58.15217859045655&bounds%5Brt%5D%5Blong%5D=31.737974855056404&"
#   #   @page = "page=#{@page_number}"
#   #
#   #   @end_url = @onliner + @price + @currency + @page
#   # end
# end
#
# Solution.new.solve

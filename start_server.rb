# frozen_string_literal: true

require 'optparse'
require_relative 'sales_tax_server'

# Set the default port
port = 3000 # Default port

# Look for bespoke port form options
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby start_server.rb [options]'

  opts.on('-p', '--port PORT', Integer, 'Port number to run the server on') do |p|
    port = p
  end
end.parse!

# Start the server
server = SalesTaxServer.new(port)
server.start

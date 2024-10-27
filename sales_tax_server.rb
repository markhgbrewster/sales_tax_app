# frozen_string_literal: true

require 'socket'
require 'uri'
require 'erb'
require_relative './models/item'
require_relative './lib/tax_calculator'
require_relative './lib/receipt_generator'

# A very basic web server that I have thrown together very quickly
# and needs a bit of TLC and is too long
class SalesTaxServer
  def initialize(port)
    @server = TCPServer.new(port)
    puts "Server is running on port #{port}..."
  end

  def start
    loop do
      socket = @server.accept
      request = socket.gets

      handle_request(request, socket) if request
      socket.close
    end
  end

  private

  def handle_request(request, socket)
    method, path = parse_request(request)

    case method
    when 'GET'
      handle_get(path, socket)
    when 'POST'
      handle_post(path, socket)
    else
      respond_with_not_found(socket)
    end
  end

  def parse_request(request)
    method, path = request.split(' ')
    [method, path]
  end

  def handle_get(path, socket)
    if path == '/'
      template = ERB.new(File.read('views/form.html.erb'))
      respond_with_html(socket, template.result)
    elsif path.start_with?('/assets/')
      serve_static_file(path, socket)
    else
      respond_with_not_found(socket)
    end
  end

  def handle_post(path, socket)
    if path == '/calculate'
      # Read the POST body
      post_data = read_post_data(socket)

      if post_data.nil?
        respond_with_bad_request(socket, 'Bad Request: No data received.')
        return
      end

      # Parse the form data from request body
      form_data = URI.decode_www_form(post_data).to_h
      items_data = parse_items_data(form_data)
      receipt = ReceiptGenerator.generate_for(items_data)

      # Render the result page
      template = ERB.new(File.read('views/result.html.erb'))
      respond_with_html(socket, template.result(binding))
    else
      respond_with_not_found(socket)
    end
  end

  def read_post_data(socket)
    # Read headers until we find an empty line
    while (line = socket.gets)
      break if line.strip.empty?

      # Look for the Content-Length header
      length = ::Regexp.last_match(1).to_i if line =~ /Content-Length:\s*(\d+)/
    end

    # If we have a length, read the body
    return nil unless defined?(length) && length

    socket.read(length)

    # No content length found, return nil
  end

  def serve_static_file(path, socket)
    file_path = ".#{path}"

    # Check if file exists and serve it, or respond with 404
    if File.exist?(file_path) && !File.directory?(file_path)
      response = static_file_response(file_path)
      socket.print response
    else
      respond_with_not_found(socket)
    end
  end

  def static_file_response(file_path)
    body = File.read(file_path)
    "HTTP/1.1 200 OK\r\n" \
      "Content-Type: #{content_type(file_path)}\r\n" \
      "Content-Length: #{body.bytesize}\r\n" \
      "\r\n" \
      "#{body}"
  end

  def content_type(file_path)
    case File.extname(file_path)
    when '.css'
      'text/css'
    when '.js'
      'application/javascript'
    end
  end

  def respond_with_html(socket, body)
    response = "HTTP/1.1 200 OK\r\n" \
      "Content-Type: text/html\r\n" \
      "Content-Length: #{body.bytesize}\r\n" \
      "\r\n" \
      "#{body}"
    socket.print response
  end

  def respond_with_bad_request(socket, message)
    response = "HTTP/1.1 400 Bad Request\r\n" \
      "Content-Type: text/plain\r\n" \
      "Content-Length: #{message.bytesize}\r\n" \
      "\r\n" \
      "#{message}"
    socket.print response
  end

  def respond_with_not_found(socket)
    response = "HTTP/1.1 404 Not Found\r\n" \
      "Content-Type: text/plain\r\n" \
      "Content-Length: 13\r\n" \
      "\r\n" \
      'Not Found'
    socket.print response
  end

  def parse_items_data(form_data)
    items = []

    # Parse and assign item data based on the index and attribute
    form_data.each do |key, value|
      next unless key =~ /^items\[(\d+)\]\[(.+)\]$/

      index = ::Regexp.last_match(1).to_i
      attribute = ::Regexp.last_match(2).to_sym

      items[index] ||= {}
      items[index][attribute] = value
    end

    # Filter out nil entries and map remaining hashes to Item instances
    items.compact.map do |item_data|
      quantity = item_data[:quantity].to_i
      name = item_data[:name]
      price = item_data[:price].to_f
      imported = item_data[:imported] == 'true'
      tax_exempt = item_data[:tax_exempt] == 'true'

      Item.new(quantity:, name:, price:, tax_exempt:, imported:)
    end
  end
end

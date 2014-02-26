require 'uri'
require 'json'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    query_string = JSON.parse(req.query_string)
    @params = parse_www_encoded_form(query_string)
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)
  end

  def require(key)
  end

  def permitted?(key)
  end

  def to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    array = URI.decode_www_form(www_encoded_form)

    array.map do |key, value|
      sub_keys = key.split('[')
      sub_keys.map do |sub_key|
        if sub_key[-1].chr == ']'
          sub_key[0..-2]
        else
          sub_key
        end
      end
    end

  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
  end
end

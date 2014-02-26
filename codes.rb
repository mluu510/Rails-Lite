def parse_www_encoded_form(www_encoded_form)
  components = www_encoded_form.split('&')

  hash = {}
  array = []
  keys = []

  components.each do |component|
    kv_pair = component.split('=')
    key = kv_pair.first
    value = kv_pair.last
    array << kv_pair
    keys << key
  end

  array.each do |key, value|
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

def translate_to_nested_hash(hash)
    output = {}

    current_hash = output
    hash.each do |keys, value|
        keys.each do |key|
            if key == keys.last
                current_hash[key] = value
            elsif current_hash.has_key?(key)
                current_hash = current_hash[key]
            else
                current_hash[key] = {}
                current_hash = current_hash[key]
            end
        end
        current_hash = output
    end

    output
end
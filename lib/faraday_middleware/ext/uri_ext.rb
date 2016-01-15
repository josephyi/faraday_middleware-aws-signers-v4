require 'uri'
require 'aws-sdk'

module URI
  def self.seahorse_encode_www_form(params)
    params.map {|key, value|
      encoded_key = encode_www_form_component(key)

      if value.nil?
        encoded_key
      elsif value.respond_to?(:to_ary)
        value.to_ary.map {|v|
          if v.nil?
            # bug?
            #encoded_key
          else
            encoded_key + '=' + uri_escape(v)
          end
        }.join('&')
      else
        encoded_key + '=' + uri_escape(value)
      end
    }.join('&')
  end

  # borrowed from Seahorse::Util.uri_escape
  def self.uri_escape(str)
    CGI.escape(str.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
  end

end

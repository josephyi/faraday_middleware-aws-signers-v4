require 'aws/core/signers/version_4'

module AwsSignersV4Ext
  def canonical_headers req
    headers = []
    req.headers.each_pair do |k,v|
      k = k.downcase
      headers << [k,v] unless k == 'authorization'
    end
    headers = headers.sort_by(&:first)
    headers.map{|k,v| "#{k}:#{canonical_header_values(v)}" }.join("\n")
  end
end

class AWS::Core::Signers::Version4
  unless AWS::Core::Signers::Version4 < AwsSignersV4Ext
    prepend AwsSignersV4Ext
  end
end



# cfn.rb
# Turns cloudformation metadata in to facts.

require 'json'

filename = "/var/lib/cfn-init/data/metadata.json"
if not File.exist?(filename)
  nil
else
  parsed = JSON.load(File.new(filename))
  parsed.default = Hash.new
  parsed["Puppet"].each do |key, value|
    actual_value = value
    if value.is_a? Array
      actual_value = value.join(',')
    end
    Facter.add("cfn_" + key) do
      setcode do
        actual_value
      end
    end
  end
end

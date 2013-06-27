# datacenter.rb
# Fact to decide which data center a host belongs to
# Uses the default gateway to decide what is the default gateway
# and then uses the first 2 octets of the IP to decide where the host
# belongs to

# stubbed in ATM - whd

Facter.add('datacenter') do
  setcode do
    'mkt-phx1'
  end
end

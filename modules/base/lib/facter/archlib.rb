# archlib.rb
# Indicates the lib folder name for redhat based systems

Facter.add(:archlib) do
    setcode do
        begin
            Facter.loadfacts()
            arch = Facter.value('architecture')
            osfamily = Facter.value('osfamily')
            if arch =~ /^x86_64/  && osfamily == 'RedHat'
                "lib64"
            else
                "lib"
            end
        end
    end
end

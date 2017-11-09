Facter.add('installed_Windows_programs') do
  confine :osfamily => :windows
  setcode do
    subkeys = nil
    allkeys = []
    programs = []
    require 'win32/registry'
    keyname = 'SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall'
    Win32::Registry::HKEY_LOCAL_MACHINE.open(keyname) do |reg|
      subkeys = reg.each_key { |key| allkeys << keyname + "\\" + key }
    end
    allkeys.each { |item|
      Win32::Registry::HKEY_LOCAL_MACHINE.open(item) do |reg|
        begin
          programs << reg['DisplayName'] + " " + reg['DisplayVersion']
        rescue
          # ignores things like AddressBook which don't have these values
        end
      end
    }
    programs
  end
end

Facter.add('installed_Windows_programs') do
  confine :osfamily => :windows
  setcode do
   # begin
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
		  end
		end
	  }
	  programs
    #rescue
 #     puts "rescued"
    #end
  end
end
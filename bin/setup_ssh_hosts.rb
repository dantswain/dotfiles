#!/usr/bin/env ruby

require 'fileutils'

def host_range base_format, range
  range.map{|i| base_format % i}
end

Header = "#### START AUTOSETUP ####\n#   #{__FILE__} on #{Time.now}"
Footer = "#### AUTOSETUP END ####"

ConfigFileName = "#{ENV['HOME']}/.ssh/config"
FileUtils.cp ConfigFileName, ConfigFileName + ".backup"
existing_config = File.open(ConfigFileName).read

finder_regex = Regexp.new("#### START.*END ####", Regexp::MULTILINE)

manual_config = existing_config.gsub(finder_regex,'')
manual_config.chomp!

out_config = manual_config

out_config << "\n"
out_config << Header
out_config << "\n"

sifi_hosts = []
sifi_hosts << host_range("dcbid%i", (0..19))
sifi_hosts << host_range("sebid%i", (0..8))
sifi_hosts << host_range("sgbid%i", (0..2))
sifi_hosts << host_range("debid%i", (0..10))
sifi_hosts << host_range("ccp%i", (0..9))
sifi_hosts << host_range("dctest%i", (1..2))
sifi_hosts << host_range("dcrpt%i", (1..4))
sifi_hosts << "dei1"
sifi_hosts << "dci1"

sifi_hosts.flatten!
sifi_user = "dswain"
sifi_domain = "simpli.fi"
sifi_identity = "~/.ssh/id_sifi"

sifi_hosts.each do |h|
  out_config << "\nHost #{h}"
  out_config << "\nUser #{sifi_user}"
  out_config << "\nHostname #{h}.#{sifi_domain}"
  out_config << "\nIdentityFile #{sifi_identity}"
  out_config << "\n"
end

out_config << "\n"
out_config << Footer
out_config << "\n"

File.open(ConfigFileName, 'wb') << out_config

#!/usr/bin/env ruby

SCRIPT_FOLDER = __dir__.freeze
PLUGINS_FOLDER = "#{SCRIPT_FOLDER}/bundle".freeze
PLUGINS_LIST_FILE = "#{SCRIPT_FOLDER}/plugins.txt".freeze

plugins_list = []

Dir["#{PLUGINS_FOLDER}/*"].each do |folder|
  url = `cd #{folder} && git config --get remote.origin.url`
  if url =~ %r{^(https?|git):\/\/}
    plugins_list << url.split('.com/').last.split('.git').first
  elsif url =~ /^(git@)/
    plugins_list << url.split(':').last.split('.git').first
  end
end

plugins_list.sort_by! { |o| o.split('/').last }

unless plugins_list.empty?
  File.open(PLUGINS_LIST_FILE, 'w+') do |f|
    list = plugins_list.each(&:strip!).join("\n")
    f.write list
    puts list
  end
end

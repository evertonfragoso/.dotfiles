#!/usr/bin/env ruby

SCRIPT_FOLDER = File.expand_path(File.dirname(File.dirname(__FILE__)))
PLUGINS_FOLDER = SCRIPT_FOLDER + '/bundle'
PLUGINS_LIST_FILE = SCRIPT_FOLDER + '/plugins.txt'
PLUGINS_LIST = []

Dir[PLUGINS_FOLDER+'/*'].each do |p|
  url = %x(cd #{p}; git config --get remote.origin.url)
  if url =~ /^(https?|git):\/\//
    PLUGINS_LIST << url.split('.com/').last.split('.git').first
  elsif url =~ /^(git@)/
    PLUGINS_LIST << url.split(':').last.split('.git').first
  end
end

PLUGINS_LIST.sort_by! { |o| o.split('/').last }

File.open(PLUGINS_LIST_FILE, 'w+') do |f|
  f.write PLUGINS_LIST.each { |x| x.strip! }.join("\n")
end

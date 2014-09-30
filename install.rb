#!/usr/bin/env ruby
# encoding: utf-8

# Given a source file of the form 'om/nomrc.dotfile', creates a
# file '~/.nomrc' that is a symbolic link to the source file.
#
# @param source [String] the path to the source file
def create_dotfile( source )
  link_name = File.join( ENV['HOME'], ".#{File.basename( source ).sub( /\.dotfile$/, '' )}" )
  skip = false

  if File.exists?( link_name )
    if File.ftype( link_name ) == 'link' && File.readlink( link_name ) == source
      skip = true
    else
      puts "File already exists (~/#{File.basename link_name}), what do you want to do? [s]kip, [o]verwrite, [b]ackup?"
      case STDIN.gets.chomp.downcase
      when 'b'
        File.rename link_name, "#{link_name}.bak"
        puts "Renamed #{link_name} to #{link_name}.bak"
      when 'o'
        File.delete link_name
        puts "Deleted #{link_name}"
      else
        skip = true
      end
    end
  end

  if skip
    puts "Skipped #{link_name}"
  else
    File.symlink( source, link_name )
    puts "Linked #{link_name} to #{source}"
  end
end

# Create symlinks for all .dotfile files under the current directory
Dir.glob( '**/*.dotfile' ).each do |source|
  create_dotfile source
end

puts 'All dotfiles have been linked!'

#!/usr/bin/env ruby
# encoding: utf-8

# Given a source file of the form 'foo/bar/bazrc.dotfile', creates a
# file '~/.bazrc' that is a symbolic link to the source file.
#
# Gracefully handles the case where the symlink already exists.
#
# @param dotfile_path [String] the path to the source file
def symlink_dotfile( dotfile_path )
  link_name = File.join( ENV['HOME'], ".#{File.basename( dotfile_path ).sub( /\.dotfile$/, '' )}" )
  skip = false

  if File.exists?( link_name ) || File.symlink?( link_name )
    if File.symlink?( link_name ) && File.readlink( link_name ) == dotfile_path
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
    File.symlink dotfile_path, link_name
    puts "Linked #{link_name} to #{dotfile_path}"
  end
end

# Create symlinks for all .dotfile files under the current directory
Dir.glob( '**/*.dotfile' ).each do |file_path|
  symlink_dotfile file_path
end

puts 'All dotfiles have been symlinked!'

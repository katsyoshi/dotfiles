#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source "https://rubygems.org"
  gem "i3ipc"
end

require "i3ipc"
require "open3"

class SwayWindowSwithcer
  def self.switch = new.switch
  def initialize
    @conn = I3Ipc::Connection.new
    @workspaces = @conn.workspaces
    @windows = Set.new
    set_windows
  end

  def switch
    return if (index = target).nil?

    con_id = @windows.to_a[index].to_h[:id]
    @conn.command("[con_id=#{con_id}] focus")
  end

  private

  def list_window = @windows.map(&:name)
  def displays = @conn.tree.nodes.reject { |display| display.name == "__i3" }

  def target
    content = nil
    Open3.popen3(['wofi', '-i', '-k', '/dev/null', '-d'].join " ") do |i, o, e, _w|
      i.puts list_window.join("\n")
      i.close
      content = o.read.strip
      list_window.index(content)
    end
  rescue => e
    @conn.command("exec notify-send '#{e.message}'")
    raise e
  end

  def set_windows
    displays.map do |display|
      @windows += listup_windows(display.nodes)
    end
  end

  def listup_windows(ary)
    res = []

    ary.each do |node|
      if node.nodes.empty?
        res << node if node.type == "con"
      else
        res += listup_windows(node.nodes)
      end
    end
    res
  end
end

SwayWindowSwithcer.switch

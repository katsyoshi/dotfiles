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
  def switch = @conn.command("[con_id=#{@windows.to_a[open].to_h[:id]}] focus")

  private
  def list_window = @windows.map(&:name)
  def displays = @conn.tree.nodes.reject { |display| display.name == "__i3" }
  def open
    Open3.popen3(['wofi', '-i', '-k', '/dev/null', '-d'].join " ") do |i, o, _e, _w|
      i.puts list_window.join("\n")
      i.close
      list_window.index(o.read.strip)
    end
  end

  def set_windows
    displays.map do |display|
      display.nodes.map { |workspace| @windows += workspace.nodes }
    end
  end
end

SwayWindowSwithcer.switch

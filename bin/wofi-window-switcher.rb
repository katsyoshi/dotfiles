#!/usr/bin/env ruby

require "json"
require "open3"
require "set"

class HyprlandWindows
  def initialize
    output, status = Open3.capture2("hyprctl", "clients", "-j")
    raise "hyprctl clients failed" unless status.success?

    @windows = JSON.parse(output).select { |window| window["mapped"] }
  end

  def labels
    @windows.map do |window|
      workspace = window.dig("workspace", "name")
      "#{workspace} [#{window["class"]}] #{window["title"]}"
    end
  end

  def focus(index)
    address = @windows.fetch(index).fetch("address")
    return if system("hyprctl", "dispatch", "focuswindow", "address:#{address}")

    raise "failed to focus Hyprland window #{address}"
  end
end

class SwayWindows
  def initialize
    require "i3ipc"

    @connection = I3Ipc::Connection.new
    @windows = Set.new
    displays.each { |display| @windows += list_windows(display.nodes) }
    @windows = @windows.to_a
  end

  def labels
    @windows.map(&:name)
  end

  def focus(index)
    id = @windows.fetch(index).to_h.fetch(:id)
    @connection.command("[con_id=#{id}] focus")
  end

  private

  def displays
    @connection.tree.nodes.reject { |display| display.name == "__i3" }
  end

  def list_windows(nodes)
    nodes.each_with_object([]) do |node, windows|
      if node.nodes.empty?
        windows << node if node.type == "con"
      else
        windows.concat(list_windows(node.nodes))
      end
    end
  end
end

def choose(labels)
  selected = nil

  Open3.popen3("wofi", "-i", "-k", "/dev/null", "-d") do |stdin, stdout, _stderr, wait|
    stdin.puts(labels)
    stdin.close
    selected = stdout.read.strip
    return nil unless wait.value.success?
  end

  labels.index(selected)
end

begin
  backend = if ENV.key?("HYPRLAND_INSTANCE_SIGNATURE") || ENV.fetch("XDG_CURRENT_DESKTOP", "").include?("Hyprland")
              HyprlandWindows.new
            else
              SwayWindows.new
            end

  index = choose(backend.labels)
  backend.focus(index) if index
rescue StandardError => error
  system("notify-send", "Window switcher", error.message)
  warn error.full_message
  exit 1
end

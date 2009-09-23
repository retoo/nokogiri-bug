require 'rubygems'
require 'nokogiri'
require 'pp'

pp Nokogiri::VERSION_INFO

# Replaces content between the <tt>_first</tt> and the <tt>_last</tt> element (including first and last) with <tt>_content</tt>.
# NOTE: I know, this method is more than ugly.
def replace_between(_first, _last, _content)
  unless _first == _last
    next_element = _first.next
    _first.unlink
    replace_between(next_element, _last, _content)
  else
    unless _content.nil?
      _first.after(_content)
    end
    _first.unlink
  end
end

input = ""
10.times do |i| 
  input += ("<p id='para-#{i}' class='default'>" + ("12&eacute;&eacute;&eacute;&eacute;3123" * 100) + "</p>")
end

puts "input length: #{input.length}"

parent = Nokogiri::HTML(input).at("body")

partial_content = ""
50.times do |i| 
  partial_content += ("<p id='para-#{i}' class='default'>" + ("12&eacute;&eacute;&eacute;&eacute;3123" * 300) + "</p>")
end

puts "replace_length: #{partial_content.length}"

first_element = parent.at("#para-0")
last_element = parent.at("#para-9")
replace_between(first_element, last_element, partial_content)
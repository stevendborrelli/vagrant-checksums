#!/usr/bin/env ruby 

require 'json'
require 'nokogiri'
require 'open-uri'
require 'mixlib/cli'


class ChecksumCLI
    include Mixlib::CLI
    
    banner "Generate Checksums for vagrant installable images"

    option :tags,
        :long => "--tags TAGS",
        :short => "-c TAGS"
end

cli = ChecksumCLI.new
cli.parse_options

url = "http://downloads.vagrantup.com"
tags = []

def get_all_tags(url)
    tags = []
    doc = Nokogiri::HTML(open(url))

    doc.css('a.tag').each do |tag|
       tags.push(tag.text)
    end
    return tags
end

if cli.config[:tags]
    puts cli.config[:tags]
else
    tags = get_all_tags(url)
    puts JSON.pretty_generate(tags)
end


def get_pkg_links(url)
    puts url
    doc = Nokogiri::HTML(open(url))
    doc.css('a.file').each do |file|
      puts file.attr('href')
   end
end

def get_all_tags
    tags.each do |tag|
        puts "tag: " + tag
        get_pkg_links(url + '/tags/' + tag)
    end
end

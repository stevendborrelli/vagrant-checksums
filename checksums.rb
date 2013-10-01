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

    option :quiet,
        :long => "--quiet",
        :short => "-q",
        :description => "Suppresses unneeded output"

    option :url,
        :long => "--url",
        :sort => "-u",
        :default => "http://downloads.vagrantup.com",
        :description => "Base url"
end

cli = ChecksumCLI.new
cli.parse_options

tags = []

def get_all_tags(url)
    tags = []
    doc = Nokogiri::HTML(open(url))

    doc.css('a.tag').each do |tag|
       tags.push(tag.text)
    end
    return tags
end

def get_checksums_for_tag(url, tag)
    get_pkg_links(url + '/tags/' + tag) 
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

if cli.config[:tags]
    get_checksums_for_tag(cli.config[:url], cli.config[:tags])
else
    tags = get_all_tags(cli.config[:url])
    if ! cli.config[:quiet] 
        puts 'Available Versions:'
    end 
    puts tags.join(" ")
end


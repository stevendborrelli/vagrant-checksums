#!/usr/bin/env ruby 

require 'fileutils'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'mixlib/cli'
require 'pathname'
require 'uri'


class ChecksumCLI
    include Mixlib::CLI
    
    banner "Generate Checksums for vagrant installable images"

    option :cachedir,
        :long => "--cachedir DIR",
        :short => "-d DIR",
        :default => "cache",
        :description => "Where to cache install files"

    option :tags,
        :long => "--tags TAGS",
        :short => "-t TAGS",
        :description => "Versions to checksum"

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
    return get_pkg_links(url + '/tags/', tag)
end


def get_pkg_links(url,tag)
    t = []
    puts url
    doc = Nokogiri::HTML(open(url + tag))
    doc.css('a.file').each do |file|
        t.push(file.attr('href'))
   end
   return t
end

def check_cache(filename)
   return File.exist?(filename)
end

def download_file(url, targetfile)
    Dir.exists?(File::dirname(targetfile)) || FileUtils.mkpath(File::dirname(targetfile))
    puts "Downloading:  " +  url
    open(targetfile, 'wb') do |file|
        file << open(url).read
    end
end

if cli.config[:tags]
    get_pkg_links(cli.config[:url] + '/tags/', cli.config[:tags]).each do |link|
        filepath = URI::parse(link).path
        fullpath = File.join(cli.config[:cachedir], cli.config[:tags], filepath)
        if check_cache(fullpath)
            puts File::basename(filepath) + " already downloaded. Skipping..."
        else
            download_file(link, fullpath)
        end
    end
else
    tags = get_all_tags(cli.config[:url])
    if ! cli.config[:quiet] 
        puts 'Available Versions:'
    end 
    puts tags.join(" ")
end


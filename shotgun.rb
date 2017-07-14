$:.unshift(*Dir[File.expand_path("vendor/*/lib", File.dirname(__FILE__))])

require "cuba"
require "cuba/safe"
require "cuba/render"
require "tilt/erb"
require "rack"
require "json"
require "mongoid"
require "shield"
require "scrivener"
require "rack/parser"

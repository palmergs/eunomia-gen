# frozen_string_literal: true

require_relative "eunomia/version"
require_relative "eunomia/selector"
require_relative "eunomia/store"
require_relative "eunomia/hash_helpers"
require_relative "eunomia/generator"
require_relative "eunomia/item"
require_relative "eunomia/element"
require_relative "eunomia/separator"
require_relative "eunomia/request"
require_relative "eunomia/result"
require_relative "eunomia/segment"
require_relative "eunomia/functions"

module Eunomia
  class Error < StandardError; end

  @@functions = Functions.new
  @@generators = Store.new

  def self.lookup(key)
    @@generators.lookup(key)
  end

  def self.generate(key, request = nil)
    request = Request.new(key) unless request
    @@generators.lookup(key).generate(request)
  end

  def self.read(path)
    @@generators.read(path)
  end

  def self.add(hsh_or_array)
    @@generators.add(hsh_or_array)
  end

  def self.add_function(name, function)
    @@functions.add(name, function)
  end

  def self.keys
    @@generators.keys
  end

  def self.request(key, alts: {}, alt_key: nil, meta: {}, tags: [], functions: [], constants: {}, unique: false)
    Request.new(key, alts:, alt_key:, meta:, tags:, functions:, constants:, unique:)
  end

  def self.apply(arr, functions)
    @@functions.apply(arr, functions)
  end
end

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

  def self.lookup(key)
    @@store ||= Store.new
    @@store.lookup(key)
  end

  def self.generate(key, request = nil)
    @@store ||= Store.new
    request = Request.new(key) unless request
    @@store.lookup(key).generate(request)
  end

  def self.read(path)
    @@store ||= Store.new
    @@store.read(path)
  end

  def self.add(hsh_or_array)
    @@store ||= Store.new
    @@store.add(hsh_or_array)
  end

  def self.keys
    @@store ||= Store.new
    @@store.keys
  end

  def self.request(key, alts: {}, alt_key: nil, meta: {}, tags: [], functions: [], constants: {}, unique: false)
    Request.new(key, alts:, alt_key:, meta:, tags:, functions:, constants:, unique:)
  end

  def self.apply(arr, functions)
    @@functions ||= Functions.new
    @@functions.apply(arr, functions)
  end
end

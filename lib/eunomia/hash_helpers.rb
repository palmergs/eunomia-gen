# frozen_string_literal: true

module Eunomia
  module HashHelpers
    def field_or_nil(hsh, key)
      hsh[key.to_sym] || hsh[key.to_s]
    end

    def field_or_raise(hsh, key)
      val = field_or_nil(hsh, key)
      raise "Missing key: #{key}" unless val

      val
    end

    def int_field(hsh, key, default = 0)
      n = field_or_nil(hsh, key)
      n.nil? ? default : n.to_i
    end

    def list_field(hsh, key)
      field = field_or_nil(hsh, key)
      return [] unless field

      field.is_a?(String) ? field.split(/\s+/) : field
    end

    def tags_field(hsh)
      tags = list_field(hsh, :tags)
      return Set.new unless tags

      Set.new(tags)
    end

    def alts_field(hsh)
      hash_field(hsh, :alts)
    end

    def meta_field(hsh)
      hash_field(hsh, :meta)
    end

    def hash_field(hsh, key)
      field = field_or_nil(hsh, key)
      return {} unless field

      field.is_a?(Hash) ? field : {}
    end
  end
end

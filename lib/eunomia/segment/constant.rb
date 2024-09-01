# frozen_string_literal: true

module Eunomia
  module Segment
    class Constant
      include Common

      CONSTANT_MATCHER = /(\p{Blank}|:space|:ws|:comma|:period|:dot|:colon|:semicolon|:dash|:minus|:hyphen|:plus|:underscore|:quote|:apostrophe|:squote|\p{Punct})/

      attr_reader :text

      def initialize(str)
        @text = str
      end

      def self.build(scanner)
        str = scanner.scan(CONSTANT_MATCHER)
        case str
        when " ", ":space", ":ws"
          Segment::SPACE
        when ":nbsp"
          Segment::NBSP
        when ",", ":comma"
          Segment::COMMA
        when ".", ":period", ":dot"
          Segment::PERIOD
        when ":", ":colon"
          Segment::COLON
        when ";", ":semicolon"
          Segment::SEMICOLON
        when "-", ":dash", ":minus", ":hyphen"
          Segment::DASH
        when "+", ":plus"
          Segment::PLUS
        when "_", ":us", ":underscore"
          Segment::UNDERSCORE
        when '"', ":quote"
          Segment::QUOTE
        when "'", ":apostrophe", ":squo"
          Segment::APOSTROPHE
        else
          new(str) if str
        end
      end
    end

    SPACE = Constant.new(" ")
    NBSP = Constant.new("")
    COMMA = Constant.new(",")
    PERIOD = Constant.new(".")
    COLON = Constant.new(":")
    SEMICOLON = Constant.new(";")
    DASH = Constant.new("-")
    PLUS = Constant.new("+")
    UNDERSCORE = Constant.new("_")
    APOSTROPHE = Constant.new("'")
    QUOTE = Constant.new('"')
    LDQUO = Constant.new("“")
    RDQUO = Constant.new("”")
    LSQUO = Constant.new("‘")
    RSQUO = Constant.new("’")
    AMP = Constant.new("&")
    MDASH = Constant.new("—")
    NDASH = Constant.new("–")
    DOLLAR = Constant.new("$")
    POUND = Constant.new("£")
    CENT = Constant.new("¢")
  end
end

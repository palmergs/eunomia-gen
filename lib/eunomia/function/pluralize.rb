module Eunomia
  module Function
    # Pluralize attempts to pluralize the last word in the array
    # if the first word is a number and not equal to 1. This is
    # mostly useful for phrases in the form "number adjective? noun"
    class Pluralize
      EXCEPTIONS = {
        "foot" => "feet",
        "axis" => "axes",
        "child" => "children",
        "codex" => "codices",
        "die" => "dice",
        "dwarf" => "dwarves",
        "goose" => "geese",
        "elf" => "elves",
        "man" => "men",
        "ox" => "oxen",
        "thief" => "thieves",
        "tooth" => "teeth",
        "wolf" => "wolves",
        "woman" => "women"
      }.freeze

      SINGLE = Set.new(%w[a an the this that my your his her its our their])

      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          num = to_num(arr[0])
          if num && num > 1
            dc = arr[-1].downcase
            arr[-1] = exceptions(dc) || others(dc) || ends_with_y(dc) || simple(dc)
          end
          arr
        end
      end

      def to_num(str)
        return 1 if SINGLE.include?(str.downcase)

        str =~ /\d+/ ? str.to_i : nil
      end

      def exceptions(str)
        EXCEPTIONS[str]
      end

      def others(str)
        if str.end_with?("s") || str.end_with?("x") || str.end_with?("z") || str.end_with?("ch") || str.end_with?("sh")
          "#{str}es"
        end
      end

      def ends_with_y(str)
        "#{str[0..-2]}ies" if str.end_with?("y")
      end

      def simple(str)
        "#{str}s"
      end
    end
  end
end

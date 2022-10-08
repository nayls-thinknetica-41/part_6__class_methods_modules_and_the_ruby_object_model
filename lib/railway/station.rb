# frozen_string_literal: true

module Railway
  ##
  # @attr_reader trains [Array[String]]
  # @attr_accessor name [String]
  class Station
    attr_reader :trains
    attr_accessor :name

    ##
    # @param name [String]
    # @return [Station]
    def initialize(name)
      raise ArgumentError if name.nil? || name.empty?

      @name = name
    end
  end
end

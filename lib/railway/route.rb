# frozen_string_literal: true

module Railway
  ##
  # @attr_reader routes [::Array[::Railway::Station]]
  class Route
    attr_reader :routes

    ##
    # @param start_station [::Railway::Station]
    # @param end_station   [::Railway::Station]
    # @raise [ArgumentError] If start_station.nil?
    # @raise [ArgumentError] If end_station.nil?
    # @return [::Railway::Route]
    def initialize(start_station, end_station)
      raise ArgumentError if start_station.nil?
      raise ArgumentError if end_station.nil?

      @routes = [start_station, end_station]
    end

    def routes
      @routes.dup
    end
  end
end

# frozen_string_literal: true

module Railway
  ##
  # @attr_reader routes [::Array[::Railway::Station]]
  class Route
    attr_reader :routes

    ##
    # @param start_station [::Railway::Station]
    # @param end_station   [::Railway::Station]
    # @raise [ArgumentError] if start_station is not station
    # @raise [ArgumentError] if end_station is not stations
    # @return [::Railway::Route]
    def initialize(start_station, end_station)
      raise ArgumentError unless station?(start_station)
      raise ArgumentError unless station?(end_station)

      @routes = [start_station, end_station]
    end

    def routes
      @routes.dup
    end

    ##
    # @param station [::Railway::Station]
    # @return [::Railway::Route]
    def insert(station)
      raise ArgumentError unless @routes.is_a?(::Array)
      raise ArgumentError unless station?(station)

      return self if exist_in_routes?(station)

      @routes.insert(@routes.find_index(@routes.last), station)

      self
    end

    ##
    # @param station [::Railway::Station]
    # @return [::Railway::Route]
    def delete(station)
      raise ArgumentError unless @routes.is_a?(::Array)
      raise ArgumentError unless station?(station)

      return self unless exist_in_routes?(station)

      @routes.delete(station)

      self
    end

    def exist_in_routes?(station)
      @routes.include?(station)
    end

    private

    ##
    # @private
    # @param station [::Railway::Station]
    # @return [Boolean]
    def station?(station)
      station.is_a?(::Railway::Station)
    end
  end
end

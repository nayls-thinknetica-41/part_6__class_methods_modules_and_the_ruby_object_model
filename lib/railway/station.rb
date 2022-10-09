# frozen_string_literal: true

module Railway
  ##
  # @attr_reader trains [Array[Railway::Train::TrainAbstract]]
  # @attr_accessor name [String]
  class Station
    attr_reader :trains
    attr_accessor :name

    ##
    # @param name [String]
    # @raise [ArgumentError] if name is nil or empty
    # @return [Station]
    def initialize(name)
      raise ArgumentError if name.nil? || name.empty?

      @name = name
      @trains = []
    end

    ##
    # @param train [Railway::Train::TrainAbstract]
    # @raise [TypeError] if train is not TrainAbstract
    # @return [Station]
    def arrivale(train)
      raise TypeError unless train?(train)

      @trains.push(train)

      self
    end

    ##
    # @param train [Railway::Train::TrainAbstract]
    # @raise [TypeError] if train is not TrainAbstract
    # @return [Station]
    def departure(train)
      raise TypeError unless train?(train)

      @trains.delete(train)

      self
    end

    private

    ##
    # @param train [Railway::Train::TrainAbstract]
    # @return [Boolean]
    def train?(train)
      train.is_a?(Railway::Train::TrainAbstract)
    end
  end
end

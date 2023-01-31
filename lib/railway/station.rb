# frozen_string_literal: true

module Railway
  ##
  # @attr name [::String]
  # @attr_reader trains [::Array[Railway::Train::TrainAbstract]]
  class Station
    attr_accessor :name
    attr_reader :trains

    ##
    # @param name [::String]
    # @raise [ArgumentError] if name is nil or empty
    # @return [Railway::Station]
    def initialize(name)
      raise ArgumentError if name.nil? || name.empty?

      @name = name
      @trains = []
    end

    def self.all
      ObjectSpace.each_object(self).to_a
    end

    def self.count
      all.count
    end

    def trains
      @trains.dup
    end

    ##
    # @param train_type [::Symbol]
    # @return [::Hash[::Symbol, Array[Railway::Train::TrainAbstract]]]
    def trains_on_type(train_type)
      trains_list_on_type = {}

      trains.each do |train|
        next unless train.type.equal?(train_type)

        trains_list_on_type.merge!(train.type => []) unless trains_list_on_type.key?(train.type)

        trains_list_on_type[train.type].push(train)
      end

      trains_list_on_type
    end

    ##
    # @param train [Railway::Train::TrainAbstract]
    # @raise [TypeError] if train is not TrainAbstract
    # @return [Railway::Station]
    def arrivale(train)
      raise TypeError unless train?(train)

      @trains.push(train)

      self
    end

    ##
    # @param train [Railway::Train::TrainAbstract]
    # @raise [TypeError] if train is not TrainAbstract
    # @return [Railway::Station]
    def departure(train)
      raise TypeError unless train?(train)

      @trains.delete(train)

      self
    end

    private

    ##
    # @private
    # @param train [Railway::Train::TrainAbstract]
    # @return [::Boolean]
    def train?(train)
      train.is_a?(Railway::Train::TrainAbstract)
    end
  end
end

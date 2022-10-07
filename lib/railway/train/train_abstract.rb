# frozen_string_literal: true

module Railway
  module Train
    ##
    # @abstract
    # @attr_reader type   [Symbol]
    # @attr        number [String]
    # @attr        speed  [Float]
    # @attr        wagons [Array[String]]
    # @attr        route  [Array[String]]
    class TrainAbstract
      attr_reader :type
      attr_accessor :number, :speed, :wagons, :route

      ##
      # @abstract
      # @param number [String]
      # @param wagons [Array[Railway::Wagon::WagonCargo | Railway::Wagon::WagonPassenger]]
      # @param route  [Array[String]]
      # @raise [RuntimeError] Cannot initialize an abstract Railway::Train::TrainAbstract
      # @return [TrainAbstract]
      def initialize(number, wagons, route)
        raise "Cannot initialize an abstract #{self.class.name}" if instance_of?(TrainAbstract)

        @number = number
        @wagons = wagons
        @route = route
      end
    end
  end
end

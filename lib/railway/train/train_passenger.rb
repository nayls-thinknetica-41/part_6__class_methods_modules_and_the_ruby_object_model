# frozen_string_literal: true

module Railway
  module Train
    ##
    # TrainPasssenger
    class TrainPassenger < TrainAbstract
      ##
      # @param number [String]
      # @param wagons [Array[String]]
      # @param route  [Array[String]]
      # @return [TrainPassenger]
      def initialize(number, wagons = [], route = [])
        super

        @type = Railway::Train::Type::PASSENGER
      end
    end
  end
end

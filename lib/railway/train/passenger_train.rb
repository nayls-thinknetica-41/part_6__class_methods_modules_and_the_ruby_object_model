# frozen_string_literal: true

module Railway
  module Train
    # PassengerTrain
    class PassengerTrain < TrainAbstract
      def initialize(number, wagons = [], route = [])
        super

        @type = Railway::Train::Type::PASSENGER
        @number = number
        @wagons = wagons
        @route = route
      end
    end
  end
end

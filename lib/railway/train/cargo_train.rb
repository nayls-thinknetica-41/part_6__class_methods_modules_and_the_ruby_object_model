# frozen_string_literal: true

module Railway
  module Train
    # CargoTrain
    class CargoTrain < TrainAbstract
      def initialize(number, wagons = [], route = [])
        super

        @type = Railway::Train::Type::CARGO
        @number = number
        @wagons = wagons
        @route = route
      end
    end
  end
end

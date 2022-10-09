# frozen_string_literal: true

module Railway
  module Train
    ##
    # TrainCargo
    class TrainCargo < TrainAbstract
      ##
      # @param number [::String]
      # @param wagons [::Array[::String]]
      # @return [TrainCargo]
      def initialize(number, wagons = [])
        super

        @type = ::Railway::Train::Type::CARGO
      end
    end
  end
end

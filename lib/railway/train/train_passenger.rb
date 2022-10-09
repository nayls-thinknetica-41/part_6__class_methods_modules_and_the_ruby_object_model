# frozen_string_literal: true

module Railway
  module Train
    ##
    # TrainPasssenger
    class TrainPassenger < ::Railway::Train::TrainAbstract
      ##
      # @param number [::String]
      # @param wagons [::Array[::String]]
      # @return [TrainPassenger]
      def initialize(number, wagons = [])
        super

        @type = ::Railway::Train::Type::PASSENGER
      end
    end
  end
end

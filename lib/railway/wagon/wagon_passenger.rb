# frozen_string_literal: true

module Railway
  module Wagon
    ##
    # WagonPassenger
    class WagonPassenger < WagonAbstract
      ##
      # @return [WagonCargo]
      def initialize
        super

        @type = Railway::Wagon::Type::PASSENGER
      end
    end
  end
end

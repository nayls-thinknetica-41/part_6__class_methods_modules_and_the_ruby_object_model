# frozen_string_literal: true

module Railway
  module Wagon
    ##
    # WagonPassenger
    class WagonPassenger < Railway::Wagon::WagonAbstract
      ##
      # @return [WagonPassenger]
      def initialize
        super

        @type = Railway::Wagon::Type::PASSENGER
      end
    end
  end
end

# frozen_string_literal: true

module Railway
  module Wagon
    ##
    # WagonCargo
    class WagonCargo < WagonAbstract
      ##
      # @return [WagonCargo]
      def initialize
        super

        @type = Railway::Wagon::Type::CARGO
      end
    end
  end
end

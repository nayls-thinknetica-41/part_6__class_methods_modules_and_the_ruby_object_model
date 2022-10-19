# frozen_string_literal: true

module Railway
  module Wagon
    ##
    # WagonCargo
    class WagonCargo < Railway::Wagon::WagonAbstract
      ##
      # @return [WagonCargo]
      def initialize
        super

        @type = Railway::Wagon::Type::CARGO
      end
    end
  end
end

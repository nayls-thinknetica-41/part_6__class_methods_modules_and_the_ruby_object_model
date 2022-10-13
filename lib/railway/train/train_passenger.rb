# frozen_string_literal: true

module Railway
  module Train
    ##
    # @abstract
    # @attr_reader type   [::Symbol]
    # @attr        number [::String]
    # @attr        speed  [::Float]
    # @attr        wagons [::Array[::Railway::Wagon::WagonAbstract]]
    # @attr        route  [::Railway::Route]
    class TrainPassenger < ::Railway::Train::TrainAbstract
      ##
      # @param number [::String]
      # @raise [RuntimeError] Cannot initialize an abstract Railway::Train::TrainAbstract
      # @return [TrainAbstract]
      def initialize(number)
        super

        @type = ::Railway::Train::Type::PASSENGER
      end

      private

      ##
      # @private
      # @param wagon [::Railway::Wagon::WagonAbstract]
      # @return bool
      def wagon_type_suitable?(wagon)
        return false unless wagon.type.equal?(::Railway::Wagon::Type::PASSENGER)

        true
      end
    end
  end
end

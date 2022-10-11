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
    class TrainAbstract
      attr_reader :type
      attr_accessor :number, :speed, :wagons, :route

      ##
      # @abstract
      # @param number [::String]
      # @param wagons [::Array[::Railway::Wagon::WagonAbstract]]
      # @raise [RuntimeError] Cannot initialize an abstract Railway::Train::TrainAbstract
      # @return [TrainAbstract]
      def initialize(number, wagons)
        raise "Cannot initialize an abstract #{self.class.name}" if instance_of?(TrainAbstract)

        @type = nil
        @number = number
        @speed = 0.0
        @wagons = wagons
        @route = nil
      end

      ##
      # @return void
      def stop
        @speed = 0.0
      end

      ##
      # @return void
      def stopped?
        return false unless @speed.zero?

        true
      end

      ##
      # @param wagon [::Railway::Wagon::WagonAbstract]
      def attach_wagon(wagon)
        raise TypeError unless wagon?(wagon)
        raise TypeError unless wagon_type_suitable?(wagon)
        return self unless stopped?

        @wagons.push(wagon)

        self
      end

      ##
      # @param wagon [::Railway::Wagon::WagonAbstract]
      def unhook_wagon(wagon)
        raise TypeError unless wagon?(wagon)
        raise TypeError unless wagon_type_suitable?(wagon)
        return self unless stopped?

        @wagons.delete(wagon)

        self
      end

      private

      ##
      # @private
      # @param wagon [::Railway::Wagon::WagonAbstract]
      # @return bool
      def wagon?(wagon)
        wagon.is_a?(::Railway::Wagon::WagonAbstract)
      end

      ##
      # @private
      # @param wagon [::Railway::Wagon::WagonAbstract]
      # @return bool
      def wagon_type_suitable?(wagon)
        raise 'Not implement method'
      end
    end
  end
end

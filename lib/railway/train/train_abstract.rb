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
      attr_accessor :number,
                    :speed,
                    :wagons,
                    :route,
                    :current_station

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
        @current_station = {}
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

      def route=(route)
        raise TypeError unless route.is_a?(::Railway::Route)

        @current_station = {
          index: 0,
          station: route.routes.first
        }

        @route = route
      end

      ##
      # @return [::Hash[::Symbol, ::Railway::Station]]
      def route_status
        return if @route.nil? || @route.routes.empty?

        current_station_index = @current_station[:index]

        case current_station_index
        when 0
          previous_station = nil
          current_station = @current_station[:station]
          next_station = @route.routes[@current_station[:index] + 1]
        when @route.routes.size - 1
          previous_station = @route.routes[@current_station[:index] - 1]
          current_station = @route.routes[@current_station[:index]]
          next_station = nil
        else
          previous_station = @route.routes[@current_station[:index] - 1]
          current_station = @route.routes[@current_station[:index]]
          next_station = @route.routes[@current_station[:index] + 1]
        end

        {
          previous_station:,
          current_station:,
          next_station:
        }
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

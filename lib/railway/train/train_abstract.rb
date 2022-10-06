# frozen_string_literal: true

# Описание 2
module Railway
  module Train
    ##
    # Какое-то описание
    # TrainAbstract
    class TrainAbstract
      attr_reader :type
      attr_accessor :number, :speed, :wagons, :route

      def initialize(_number, _wagons, _route)
        raise "Cannot initialize an abstract #{self.class.name}" if instance_of?(TrainAbstract)
      end
    end
  end
end

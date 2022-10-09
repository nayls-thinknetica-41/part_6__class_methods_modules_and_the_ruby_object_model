# frozen_string_literal: true

module Railway
  module Wagon
    ##
    # @abstract
    # @attr_reader type [::Symbol]
    class WagonAbstract
      attr_reader :type

      ##
      # @abstract
      # @raise [RuntimeError] Cannot initialize an abstract Railway::Train::TrainAbstract
      # @return [WagonAbstract]
      def initialize
        raise "Cannot initialize an abstract #{self.class.name}" if instance_of?(WagonAbstract)
      end
    end
  end
end

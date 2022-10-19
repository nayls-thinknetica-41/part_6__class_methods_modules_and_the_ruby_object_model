# frozen_string_literal: true

require_relative 'seed'

module Railway
  ##
  # Railway::Cli
  module Cli
    def self.state
      @state || Cli.seed
    end

    def self.state=(state)
      @state = state
    end

    ##
    # Railway::Cli::Main
    module Main
      HELP = "Usage:\n" \
             "    train.rb SUBCOMMAND ...\n" \
             "\n" \
             "Control subcommands:\n" \
             "    [i]nspect\n" \
             "    [q]uit\n" \
             "\n" \
             "Subcommands:\n" \
             "    [s]tation\n" \
             "    [t]rain\n" \
             "    [r]oute\n" \
             "    [w]agon\n" \
             "\n"

      class << self
        attr_accessor :command

        def help
          puts HELP
        end

        def control(commands)
          case commands
          when 'i', 'inspect'
            pp Cli.state
          when 'q', 'quit'
            exit 0
          when 's', 'station'
            Railway::Cli::Station.help_and_control
          when 't', 'train'
            Railway::Cli::Train.help_and_control
          when 'r', 'route'
            Railway::Cli::Route.help_and_control
          when 'w', 'wagon'
            Railway::Cli::Wagon.help_and_control
          else
            help
          end
        end
      end
    end
  end
end

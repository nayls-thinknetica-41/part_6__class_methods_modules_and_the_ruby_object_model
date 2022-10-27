# frozen_string_literal: true

module Railway
  module Cli
    ##
    # Railway::Cli::Wagon
    module Wagon
      HELP = "Usage:\n" \
             "    train.rb wagon SUBCOMMAND ...\n" \
             "\n" \
             "Control subcommands:\n" \
             "    [q]uit\n" \
             "    [p]revious\n" \
             "\n" \
             "Subcommands:\n" \
             "    [c]reate\n" \
             "    [g]et\n" \
             "    [d]elete\n" \
             "\n" \
             "Commands:\n" \
             "    [l]ist\n" \
             "\n"

      class << self
        attr_accessor :command

        def help
          puts HELP
        end

        def control(commands)
          case commands
          when 'q', 'quit'
            exit 0
          when 'p', 'previous'
            Cli::Main.help
          when 'c', 'create'
            puts '(wagon) >> [0] cargo, [1] passenger'
            printf '(wagon) >> Выберите тип вагона: '
            wagon_type = gets.chomp.to_i
            case wagon_type
            when 0
              create_wagons(::Railway::Wagon::WagonCargo.new)
            when 1
              create_wagons(::Railway::Wagon::WagonPassenger.new)
            else
              '(wagon) >> Введен неверный тип'
            end
            help_and_control
          when 'g', 'get'
            printf '(wagon) >> Введите ID вагона: '
            wagon_id = gets.chomp.to_i
            get_wagon(wagon_id)
            help_and_control
          when 'd', 'delete'
            printf '(wagon) >> Введите ID вагона: '
            wagon_id = gets.chomp.to_i
            delete_wagons(wagon_id)
            help_and_control
          when 'l', 'list'
            list_wagons
            help_and_control
          else
            help_and_control
          end
        end

        def get_wagon(wagon_id, format: :terminal)
          wagon = Cli::State.wagons[wagon_id]

          if wagon.nil?
            puts '(wagon) >> Вагон не найден'
            return nil
          end

          if format == :terminal
            puts "[#{wagon_id}] #{wagon.type}"
            puts ''
          end

          wagon
        end

        def list_wagons(format: :terminal)
          wagons = Cli::State.wagons

          if wagons.nil?
            puts '(wagon) >> Нет вагонов'
            return nil
          end

          if format == :terminal
            wagons.each_with_index do |wagon, idx|
              puts "[#{idx}] #{wagon.type}"
            end
            puts ''
          end

          wagons
        end

        def create_wagons(wagon)
          Cli::State.wagons(wagon)
        end

        def delete_wagons(wagon_id)
          unless Cli::State.key?(:wagons)
            puts '(wagon) >> Нет вагонов'
            return
          end

          wagon = Cli::State.wagons[wagon_id]
          if wagon.nil?
            puts '(wagon) >> Вагон не найден'
          else
            Cli::State.wagons.delete_at(wagon_id)
          end
        end

        def help_and_control
          help
          output_and_control
        end

        def output_and_control
          printf '(wagon) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

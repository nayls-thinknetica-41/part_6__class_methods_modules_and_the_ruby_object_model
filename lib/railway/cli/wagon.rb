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
            printf '(wagon) >> Введите название станции: '
            wagon_name = gets.chomp
            save_wagons(::Railway::Station.new(wagon_name))
            help_and_control
          when 'g', 'get'
            printf '(wagon) >> Введите ID станции: '
            wagon_id = gets.chomp.to_i
            get_wagon(wagon_id)
            help_and_control
          when 'd', 'delete'
            printf '(wagon) >> Введите ID станции: '
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

        def get_wagon(wagon_id)
          wagon = Cli.state[:wagons][wagon_id]

          puts "[#{wagon_id}] #{wagon.type}"
          puts
        end

        def list_wagons
          Cli.state[:wagons].each_with_index do |st, idx|
            puts "[#{idx}] #{st.type}"
          end
          puts
        end

        def save_wagons(wagon)
          if Cli.state.key?(:wagons)
            Cli.state[:wagons].push(wagon)
          else
            Cli.state = { wagons: [wagon] }
          end
        end

        def delete_wagons(wagon_id)
          unless Cli.state.key?(:wagons)
            puts '(wagon) >> Нет станций'
            return
          end

          wagon = Cli.state[:wagons][wagon_id]
          if wagon.nil?
            puts '(wagon) >> Cтанция не найдена'
          else
            Cli.state[:wagons].delete_at(wagon_id)
          end
        end

        def help_and_control
          help
          printf '(wagon) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

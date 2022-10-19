# frozen_string_literal: true

module Railway
  module Cli
    ##
    # Railway::Cli::Station
    module Station
      HELP = "Usage:\n" \
             "    train.rb station SUBCOMMAND ...\n" \
             "\n" \
             "Control subcommands:\n" \
             "    [q]uit\n" \
             "    [p]revious\n" \
             "\n" \
             "Subcommands:\n" \
             "    [c]reate\n" \
             "    [g]et\n" \
             "    [e]dit\n" \
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
            printf '(station): Введите название станции: '
            station_name = gets.chomp
            save_stations(::Railway::Station.new(station_name))
            help_and_control
          when 'g', 'get'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            get_station(station_id)
            help_and_control
          when 'e', 'edit'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            edit_stations(station_id)
            help_and_control
          when 'd', 'delete'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            delete_stations(station_id)
            help_and_control
          when 'l', 'list'
            list_stations
            help_and_control
          else
            help_and_control
          end
        end

        def get_station(station_id)
          station = Cli.state[:stations][station_id]

          puts "[#{station_id}] #{station.name}"
          station.trains.each_with_index do |tr, idx|
            puts "-- #{idx} #{tr.number} #{tr.type}"
          end
          puts
        end

        def list_stations
          Cli.state[:stations].each_with_index do |st, idx|
            puts "[#{idx}] #{st.name}"
            st.trains.each_with_index do |tr, idx|
              puts "-- #{idx} #{tr.number} #{tr.type}"
            end
            puts
          end
        end

        def edit_stations(station_id)
          unless Cli.state.key?(:stations)
            puts '(station) >> Нет станций'
            return
          end

          station = Cli.state[:stations][station_id]
          if station.nil?
            puts '(station) >> Станция не найдена'
          else
            printf '(station) >> Введите новое название станции: '
            Cli.state[:stations][station_id].name = gets.chomp
          end
        end

        def save_stations(station)
          if Cli.state.key?(:stations)
            Cli.state[:stations].push(station)
          else
            Cli.state = { stations: [station] }
          end
        end

        def delete_stations(station_id)
          unless Cli.state.key?(:stations)
            puts '(station) >> Нет станций'
            return
          end

          station = Cli.state[:stations][station_id]
          if station.nil?
            puts '(station) >> Станция не найдена'
          else
            Cli.state[:stations].delete_at(station_id)
          end
        end

        def help_and_control
          help
          printf '(station) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

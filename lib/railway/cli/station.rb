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
             "    arrivale\n" \
             "    departure\n" \
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
            create_stations(::Railway::Station.new(station_name))
            output_and_control
          when 'g', 'get'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            get_station(station_id)
            output_and_control
          when 'e', 'edit'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            edit_stations(station_id)
            output_and_control
          when 'd', 'delete'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            delete_stations(station_id)
            output_and_control
          when 'l', 'list'
            list_stations
            output_and_control
          when 'arrivale'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            printf '(station) >> Введите ID поезда: '
            train_id = gets.chomp.to_i
            arrivale_train(station_id, train_id)
            output_and_control
          when 'departure'
            printf '(station) >> Введите ID станции: '
            station_id = gets.chomp.to_i
            printf '(station) >> Введите ID поезда: '
            train_id = gets.chomp.to_i
            departure_train(station_id, train_id)
            output_and_control
          else
            help_and_control
          end
        end

        def get_station(station_id, format: :terminal)
          station = Cli::State.stations[station_id]

          if station.nil?
            puts '(station) >> Станция не найдена'
            return nil
          end

          if format == :terminal
            puts "[#{station_id}] #{station.name}"
            station.trains.each_with_index do |tr, idx|
              puts "-- #{idx} #{tr.number} #{tr.type}"
            end
            puts ''
          end

          station
        end

        def list_stations(format: :terminal)
          stations = Cli::State.stations

          if stations.nil?
            puts '(station) >> Нет станций'
            return nil
          end

          if format == :terminal
            stations.each_with_index do |st, idx|
              puts "[#{idx}] #{st.name}"
              st.trains.each_with_index do |tr, idx|
                puts "-- #{idx} #{tr.number} #{tr.type}"
              end
              puts ''
            end
          end

          stations
        end

        def edit_stations(station_id)
          unless Cli::State.key?(:stations)
            puts '(station) >> Нет станций'
            return
          end

          station = Cli::State.stations[station_id]
          if station.nil?
            puts '(station) >> Станция не найдена'
          else
            printf '(station) >> Введите новое название станции: '
            Cli::State.stations[station_id].name = gets.chomp
          end
        end

        def create_stations(station)
          Cli::State.stations(station)
        end

        def delete_stations(station_id)
          unless Cli::State.key?(:stations)
            puts '(station) >> Нет станций'
            return
          end

          if Cli::State.stations[station_id].nil?
            puts '(station) >> Станция не найдена'
          else
            Cli::State.stations.delete_at(station_id)
          end
        end

        def arrivale_train(station_id, train_id)
          station = Cli::State.stations[station_id]
          train = Cli::State.trains[train_id]

          if station.nil?
            puts '(station) >> Станция не найдена'
            return nil
          end

          if train.nil?
            puts '(station) >> Поезд не найден'
            return nil
          end

          station.arrivale(train)

          nil
        end

        def departure_train(station_id, train_id)
          station = Cli::State.stations[station_id]
          train = Cli::State.trains[train_id]

          if station.nil?
            puts '(station) >> Станция не найдена'
            return nil
          end

          if train.nil?
            puts '(station) >> Поезд не найден'
            return nil
          end

          station.departure(train)

          nil
        end

        def help_and_control
          help
          output_and_control
        end

        def output_and_control
          printf '(station) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

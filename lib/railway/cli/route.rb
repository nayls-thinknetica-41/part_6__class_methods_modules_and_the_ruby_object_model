# frozen_string_literal: true

module Railway
  module Cli
    ##
    # Railway::Cli::Route
    module Route
      HELP = "Usage:\n" \
             "    route.rb route SUBCOMMAND ...\n" \
             "\n" \
             "Control subcommands:\n" \
             "    [q]uit\n" \
             "    [p]revious\n" \
             "\n" \
             "Subcommands:\n" \
             "    [c]reate\n" \
             "    [g]et\n" \
             "    [e]dit\n" \
             "       [a]append (middle station)\n" \
             "       [r]emove (middle station)\n" \
             "    [d]elete\n" \
             "\n" \
             "Commands:\n" \
             "    [l]ist\n" \
             "\n"

      HELP_EDIT = "Usage:\n" \
             "    route.rb route SUBCOMMAND ...\n" \
             "\n" \
             "Subcommands:\n" \
             "    [e]dit\n" \
             "       [a]append (middle station)\n" \
             "       [r]emove (middle station)\n" \
             "\n"

      class << self
        attr_accessor :command

        def help
          puts HELP
        end

        def help_edit
          puts HELP_EDIT
        end

        def control(commands)
          case commands
          when 'q', 'quit'
            exit 0
          when 'p', 'previous'
            Cli::Main.help
          when 'c', 'create'
            printf '(route): Введите ID начальной станции: '
            station_1_id = gets.chomp.to_i
            printf '(route): Введите ID конечной станции: '
            station_2_id = gets.chomp.to_i
            create_routes(
              ::Railway::Route.new(
                Cli::Station.get_station(station_1_id, format: :object),
                Cli::Station.get_station(station_2_id, format: :object)
              )
            )
            output_and_control
          when 'g', 'get'
            printf '(route) >> Введите ID маршрута: '
            route_id = gets.chomp.to_i
            get_route(route_id)
            output_and_control
          when 'e', 'edit'
            help_edit
            case gets.chomp
            when 'a', 'append'
              printf '(route) >> Введите ID маршрута: '
              route_id = gets.chomp.to_i
              printf '(route): Введите ID станции: '
              station_id = gets.chomp.to_i
              append_station_in_routes(route_id, station_id)
            when 'r', 'remove'
              printf '(route) >> Введите ID маршрута: '
              route_id = gets.chomp.to_i
              printf '(route): Введите ID станции: '
              station_id = gets.chomp.to_i
              remove_station_in_routes(route_id, station_id)
            end
            output_and_control
          when 'd', 'delete'
            printf '(route) >> Введите ID маршрута: '
            route_id = gets.chomp.to_i
            delete_routes(route_id)
            output_and_control
          when 'l', 'list'
            list_routes
            output_and_control
          else
            help_and_control
          end
        end

        def get_route(route_id)
          puts "[#{route_id}] route"
          Cli::State.routes[route_id].routes.each_with_index do |st, idx|
            puts "-- #{idx} #{st.name}"
          end

          puts
        end

        def list_routes
          Cli::State.routes.each_with_index do |route, idx|
            puts "[#{idx}] route"
            route.routes.each_with_index do |st, idx|
              puts "-- #{idx} #{st.name}"
            end
            puts
          end
        end

        def append_station_in_routes(route_id, station_id)
          unless Cli::State.key?(:routes)
            puts '(route) >> Нет маршрутов'
            return
          end

          route = Cli::State.routes[route_id]
          if route.nil?
            puts '(route) >> Маршрут не найден'
          else
            Cli::State.routes[route_id].insert(Cli::Station.get_station(station_id, format: :object))
          end
        end

        def remove_station_in_routes(route_id, station_id)
          unless Cli::State.key?(:routes)
            puts '(route) >> Нет маршрутов'
            return
          end

          route = Cli::State.routes[route_id]
          if route.nil?
            puts '(route) >> Маршрут не найден'
          else
            Cli::State.routes[route_id].delete(Cli::Station.get_station(station_id, format: :object))
          end
        end

        def create_routes(route)
          Cli::State.routes(route)
        end

        def delete_routes(route_id)
          unless Cli::State.key?(:routes)
            puts '(route) >> Нет маршрутов'
            return
          end

          route = Cli::State.routes[route_id]
          if route.nil?
            puts '(route) >> Маршрут не найдена'
          else
            Cli::State.routes.delete_at(route_id)
          end
        end

        def help_and_control
          help
          output_and_control
        end

        def output_and_control
          printf '(route) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

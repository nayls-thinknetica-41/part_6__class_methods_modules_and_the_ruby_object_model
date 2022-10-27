# frozen_string_literal: true

module Railway
  module Cli
    ##
    # Railway::Cli::State
    module State
      class << self
        def key?(key)
          state.key?(key)
        end

        def stations(station = nil)
          unless station.nil?
            if state.key?(:stations) && state[:stations].is_a?(Array)
              state[:stations].push(station)
            else
              state[:stations] = [station]
            end
          end

          state[:stations]
        end

        def station?(station)
          if stations.include(station)
            true
          else
            false
          end
        end

        def routes(route = nil)
          unless route.nil?
            if state.key?(:routes) && state[:routes].is_a?(Array)
              state[:routes].push(route)
            else
              state[:routes] = [route]
            end
          end

          state[:routes]
        end

        def route?(route)
          if routes.include(route)
            true
          else
            false
          end
        end

        ##
        # @return Array[Railway::Wagon::WagonAbstract]
        def wagons(wagon = nil)
          unless wagon.nil?
            if state.key?(:wagons) && state[:wagons].is_a?(Array)
              state[:wagons].push(wagon)
            else
              state[:wagons] = [wagon]
            end
          end

          state[:wagons]
        end

        def wagon?(wagon)
          if wagons.include(wagon)
            true
          else
            false
          end
        end

        def trains(train = nil)
          unless train.nil?
            if state.key?(:trains) && state[:trains].is_a?(Array)
              state[:trains].push(train)
            else
              state[:trains] = [train]
            end
          end

          state[:trains]
        end

        def train?(train)
          if trains.include(train)
            true
          else
            false
          end
        end

        private

        def state
          @state || seed
        end

        def state=(state)
          @state = state
        end

        def seed
          seed_stations = [
            Railway::Station.new('Station_0'),
            Railway::Station.new('Station_1'),
            Railway::Station.new('Station_2'),
            Railway::Station.new('Station_3'),
            Railway::Station.new('Station_4')
          ]

          seed_routes = [
            Railway::Route.new(seed_stations[0], seed_stations[1]).insert(seed_stations[2]).insert(seed_stations[3]).insert(seed_stations[4]),
            Railway::Route.new(seed_stations[0], seed_stations[2]).insert(seed_stations[3]).insert(seed_stations[4]),
            Railway::Route.new(seed_stations[0], seed_stations[3]).insert(seed_stations[4]),
            Railway::Route.new(seed_stations[0], seed_stations[4])
          ]

          seed_wagons = [
            Railway::Wagon::WagonCargo.new,
            Railway::Wagon::WagonCargo.new,
            Railway::Wagon::WagonCargo.new,
            Railway::Wagon::WagonCargo.new,

            Railway::Wagon::WagonPassenger.new,
            Railway::Wagon::WagonPassenger.new,
            Railway::Wagon::WagonPassenger.new,
            Railway::Wagon::WagonPassenger.new
          ]

          seed_trains = [
            (
              t = Railway::Train::TrainCargo.new('Cargo_100').attach_wagon(seed_wagons[0]).attach_wagon(seed_wagons[1])
              t.route = seed_routes[0]
              t
            ),
            (
              t = Railway::Train::TrainCargo.new('Cargo_101').attach_wagon(seed_wagons[2])
              t.route = seed_routes[1]
              t
            ),
            (
              t = Railway::Train::TrainCargo.new('Cargo_102').attach_wagon(seed_wagons[3])
              t.route = seed_routes[2]
              t
            ),

            (
              t = Railway::Train::TrainPassenger.new('Passenger_103').attach_wagon(seed_wagons[4]).attach_wagon(seed_wagons[5])
              t.route = seed_routes[1]
              t
            ),
            (
              t = Railway::Train::TrainPassenger.new('Passenger_104').attach_wagon(seed_wagons[6])
              t.route = seed_routes[2]
              t
            ),
            (
              t = Railway::Train::TrainPassenger.new('Passenger_105').attach_wagon(seed_wagons[7])
              t.route = seed_routes[3]
              t
            )
          ]

          seed_stations[0].arrivale(seed_trains[0]).arrivale(seed_trains[1]).arrivale(seed_trains[2])
          seed_stations[1].arrivale(seed_trains[1]).arrivale(seed_trains[2]).arrivale(seed_trains[3])
          seed_stations[2].arrivale(seed_trains[2]).arrivale(seed_trains[3]).arrivale(seed_trains[4])
          seed_stations[3].arrivale(seed_trains[3]).arrivale(seed_trains[4]).arrivale(seed_trains[5])
          seed_stations[4].arrivale(seed_trains[4]).arrivale(seed_trains[5])

          @state = {
            stations: seed_stations,
            routes: seed_routes,
            wagons: seed_wagons,
            trains: seed_trains
          }
        end
      end
    end
  end
end

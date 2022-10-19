# frozen_string_literal: true

require 'rspec'

describe Railway::Train::TrainPassenger do
  let(:wagon_cargo1) { Railway::Wagon::WagonCargo.new }
  let(:wagon_cargo2) { Railway::Wagon::WagonCargo.new }
  let(:wagon_passenger1) { Railway::Wagon::WagonPassenger.new }
  let(:wagon_passenger2) { Railway::Wagon::WagonPassenger.new }

  let(:station_st1) { Railway::Station.new('st1') }
  let(:station_st2) { Railway::Station.new('st2') }
  let(:station_st3) { Railway::Station.new('st3') }

  let(:train_default) { Railway::Train::TrainPassenger.new('101') }
  let(:train_full) { Railway::Train::TrainPassenger.new('102') }
  let(:train_with_default_route) {
    train_default.route = Railway::Route.new(station_st1, station_st2)
    train_default
  }
  let(:train_with_full_route) {
    train_default.route = Railway::Route.new(station_st1, station_st2).insert(station_st3)
    train_default
  }

  context '#initialize' do
    specify 'тип объекта Railway::Train::PassengerTrain' do
      expect(train_default).to be_an_instance_of(Railway::Train::TrainPassenger)
    end

    specify 'нельзя создать поезд без номера' do
      expect { Railway::Train::TrainPassenger.new }.to raise_error(ArgumentError)
    end

    specify 'только @param number обязательный' do
      expect(train_default).to be_an_instance_of(Railway::Train::TrainPassenger)
    end

    specify 'список вагонов пуст' do
      expect(train_default.wagons).to eq([])
    end

    specify 'список маршрутов пуст' do
      expect(train_default.route).to eq(nil)
    end

    specify 'тип поезда - :passenger' do
      expect(train_default.type).to eq(Railway::Train::Type::PASSENGER)
    end

    context '@param number' do
      specify 'можно указать' do
        expect(train_full.number).to eq('102')
      end

      specify 'тип String' do
        expect(train_full.number).to be_an_instance_of(String)
      end
    end
  end

  context '#speed' do
    specify 'по умолчанию 0' do
      expect(train_default.speed).to eq(0.0)
    end

    specify 'тип Float' do
      expect(train_default.speed).to be_an_instance_of(Float)
    end

    it 'можно набрать скорость' do
      expect(train_default.speed = 15.5).to eq(15.5)
    end

    context 'остановка' do
      it 'можно остановиться изменив @speed' do
        train_default.speed = 15.5
        expect(train_default.speed).to eq(15.5)

        expect(train_default.speed = 0.0).to eq(0.0)
      end

      it 'с помощью метода #stop' do
        train_default.speed = 15.5
        expect(train_default.speed).to eq(15.5)

        train_default.stop
        expect(train_default.speed).to eq(0.0)
      end
    end
  end

  context '#wagons' do
    specify 'может возвращать количество вагонов' do
      expect(train_full.wagons).to eq([])
    end
  end

  context '#attach_wagon' do
    specify 'прицепить вагон' do
      expect(
        train_default
          .attach_wagon(wagon_passenger1)
          .wagons
      ).to eq([wagon_passenger1])
    end

    specify 'прицепить несколько вагонов сразу' do
      expect(
        train_default
          .attach_wagon(wagon_passenger1)
          .attach_wagon(wagon_passenger2)
          .wagons
      ).to eq([wagon_passenger1, wagon_passenger2])
    end

    specify 'нельзя прицепить вагон не подходящего типа' do
      expect do
        train_default.attach_wagon(wagon_cargo1)
      end.to raise_error(TypeError)
    end
  end

  context '#unhook_wagon' do
    let(:train_with_one_wagons) { train_default.attach_wagon(wagon_passenger1) }
    let(:train_with_two_wagons) { train_default.attach_wagon(wagon_passenger1).attach_wagon(wagon_passenger2) }

    specify 'отцепить вагон вагон' do
      expect(
        train_with_one_wagons
          .unhook_wagon(wagon_passenger1)
          .wagons
      ).to eq([])
    end

    specify 'прицепить несколько вагонов сразу' do
      expect(
        train_with_two_wagons
          .unhook_wagon(wagon_passenger1)
          .unhook_wagon(wagon_passenger2)
          .wagons
      ).to eq([])
    end

    specify 'нельзя прицепить вагон не подходящего типа' do
      expect do
        train_with_one_wagons.unhook_wagon(wagon_cargo1)
      end.to raise_error(TypeError)
    end

    specify 'нельзя прицепить вагон в движении' do
      train_with_one_wagons.speed = 15.5
      train_with_one_wagons.unhook_wagon(wagon_passenger1)

      expect(train_with_one_wagons.wagons).to eq([wagon_passenger1])
    end
  end

  context '#route' do
    specify 'может получить маршрут' do
      expect(train_with_full_route.route.routes).to eq([station_st1, station_st3, station_st2])
    end

    specify 'маршрут корректного типа' do
      expect(train_with_full_route.route).to be_an_instance_of(Railway::Route)
    end

    specify 'поезд при назначении маршрута перемещается на первую станцию' do
      expect(train_with_full_route.current_station).to eq({ index: 0, station: station_st1 })
    end
  end

  context '#route_status' do
    specify 'выводит предыдущую, текущую и следующую станцию' do
      expect(train_with_default_route.route_status)
        .to eq({
                 previous_station: nil,
                 current_station: station_st1,
                 next_station: station_st2
               })
    end
  end

  context 'move train' do
    context '#forward' do
      specify 'поезд перемещается на следующую станцию по маршруту' do
        expect(train_with_full_route.forward.current_station)
          .to eq({
                   index: 1,
                   station: station_st3
                 })
      end

      specify 'поезд никуда не перемещается если нет следующей станции' do
        expect(train_with_full_route.forward.forward.forward.current_station)
          .to eq({
                   index: 2,
                   station: station_st2
                 })
      end

      specify 'изменяется статус поездки на новую станцию' do
        expect(train_with_full_route.forward.forward.forward.route_status)
          .to eq({
                   previous_station: station_st3,
                   current_station: station_st2,
                   next_station: nil
                 })
      end
    end

    context '#backward' do
      let(:train_end_with_full_route) { train_with_full_route.forward.forward }

      specify 'поезд перемещается на предыдущую станцию по маршруту' do
        expect(train_end_with_full_route.backward.current_station)
          .to eq({
                   index: 1,
                   station: station_st3
                 })
      end

      specify 'поезд никуда не перемещается если нет предыдущей станции' do
        expect(train_end_with_full_route.backward.backward.backward.current_station)
          .to eq({
                   index: 0,
                   station: station_st1
                 })
      end

      specify 'изменяется статус поездки на новую станцию' do
        expect(train_end_with_full_route.backward.route_status)
          .to eq({
                   previous_station: station_st1,
                   current_station: station_st3,
                   next_station: station_st2
                 })
      end
    end
  end
end

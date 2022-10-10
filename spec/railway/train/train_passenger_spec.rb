# frozen_string_literal: true

require 'rspec'

describe ::Railway::Train::TrainPassenger do
  let(:wagon_cargo1) { ::Railway::Wagon::WagonCargo.new }
  let(:wagon_cargo2) { ::Railway::Wagon::WagonCargo.new }
  let(:wagon_passenger1) { ::Railway::Wagon::WagonPassenger.new }
  let(:wagon_passenger2) { ::Railway::Wagon::WagonPassenger.new }

  let(:train_default) { ::Railway::Train::TrainPassenger.new('101') }
  let(:train_full) { ::Railway::Train::TrainPassenger.new('102', %w[wg1 wg2]) }

  context '#initialize' do
    specify 'тип объекта ::Railway::Train::PassengerTrain' do
      expect(::Railway::Train::TrainPassenger.new('100')).to be_an_instance_of(::Railway::Train::TrainPassenger)
    end

    specify 'нельзя создать поезд без номера' do
      expect { ::Railway::Train::TrainPassenger.new }.to raise_error(ArgumentError)
    end

    specify 'только @param number обязательный' do
      expect(::Railway::Train::TrainPassenger.new('100')).to be_an_instance_of(::Railway::Train::TrainPassenger)
    end

    specify 'список вагонов пуст' do
      expect(train_default.wagons).to eq([])
    end

    specify 'список маршрутов пуст' do
      expect(train_default.route).to eq(nil)
    end

    specify 'тип поезда - :passenger' do
      expect(train_default.type).to eq(::Railway::Train::Type::PASSENGER)
    end

    context '@param number' do
      specify 'можно указать' do
        expect(train_full.number).to eq('102')
      end

      specify 'тип String' do
        expect(train_full.number).to be_an_instance_of(String)
      end
    end

    context '@param wagons' do
      specify 'можно указать' do
        expect(train_full.wagons).to eq(%w[wg1 wg2])
      end

      specify 'можно изменить' do
        train_full.wagons = ['wg1']
        expect(train_full.wagons).to eq(%w[wg1])
      end

      specify 'тип Array' do
        expect(train_full.wagons).to be_an_instance_of(Array)
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
      expect(train_full.wagons).to eq(%w[wg1 wg2])
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
end

# frozen_string_literal: true

require 'rspec'

describe ::Railway::Train::TrainCargo do
  let(:wagon_cargo1) { ::Railway::Wagon::WagonCargo.new }
  let(:wagon_cargo2) { ::Railway::Wagon::WagonCargo.new }
  let(:wagon_passenger1) { ::Railway::Wagon::WagonPassenger.new }
  let(:wagon_passenger2) { ::Railway::Wagon::WagonPassenger.new }

  let(:train_default) { ::Railway::Train::TrainCargo.new('101') }
  let(:train_full) { ::Railway::Train::TrainCargo.new('102', %w[wg1 wg2]) }

  context '#initialize' do
    specify 'тип объекта ::Railway::Train::CargoTrain' do
      expect(train_default).to be_an_instance_of(::Railway::Train::TrainCargo)
    end

    specify 'нельзя создать поезд без номера' do
      expect { ::Railway::Train::TrainCargo.new }.to raise_error(ArgumentError)
    end

    specify 'только @number обязательный' do
      expect(train_default).to be_an_instance_of(::Railway::Train::TrainCargo)
    end

    specify 'список вагонов пуст' do
      expect(train_default.wagons).to eq([])
    end

    specify 'список маршрутов пуст' do
      expect(train_default.route).to eq(nil)
    end

    specify 'тип поезда - :cargo' do
      expect(train_default.type).to eq(::Railway::Train::Type::CARGO)
    end

    context '@param number' do
      example 'можно указать' do
        expect(train_full.number).to eq('102')
      end

      example 'можно изменить' do
        train_full.number = '100'
        expect(train_full.number).to eq('100')
      end

      specify 'тип String' do
        expect(train_full.number).to be_an_instance_of(String)
      end
    end

    context '@param wagons' do
      example 'можно указать' do
        expect(train_full.wagons).to eq(%w[wg1 wg2])
      end

      example 'можно изменить' do
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
          .attach_wagon(wagon_cargo1)
          .wagons
      ).to eq([wagon_cargo1])
    end

    specify 'прицепить несколько вагонов сразу' do
      expect(
        train_default
          .attach_wagon(wagon_cargo1)
          .attach_wagon(wagon_cargo2)
          .wagons
      ).to eq([wagon_cargo1, wagon_cargo2])
    end

    specify 'нельзя прицепить вагон не подходящего типа' do
      expect do
        train_default.attach_wagon(wagon_passenger1)
      end.to raise_error(TypeError)
    end

    specify 'нельзя прицепить вагон в движении' do
      train_default.speed = 15.5
      train_default.attach_wagon(wagon_cargo1)

      expect(train_default.wagons).to eq([])
    end
  end

  context '#unhook_wagon' do
    let(:train_with_one_wagons) { train_default.attach_wagon(wagon_cargo1) }
    let(:train_with_two_wagons) { train_default.attach_wagon(wagon_cargo1).attach_wagon(wagon_cargo2) }

    specify 'отцепить вагон вагон' do
      expect(
        train_with_one_wagons
          .unhook_wagon(wagon_cargo1)
          .wagons
      ).to eq([])
    end

    specify 'прицепить несколько вагонов сразу' do
      expect(
        train_with_two_wagons
          .unhook_wagon(wagon_cargo1)
          .unhook_wagon(wagon_cargo2)
          .wagons
      ).to eq([])
    end

    specify 'нельзя прицепить вагон не подходящего типа' do
      expect do
        train_with_one_wagons.unhook_wagon(wagon_passenger1)
      end.to raise_error(TypeError)
    end

    specify 'нельзя прицепить вагон в движении' do
      train_with_one_wagons.speed = 15.5
      train_with_one_wagons.unhook_wagon(wagon_cargo1)

      expect(train_with_one_wagons.wagons).to eq([wagon_cargo1])
    end
  end
end

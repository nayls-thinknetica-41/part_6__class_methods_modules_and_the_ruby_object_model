# frozen_string_literal: true

require 'rspec'

describe Railway::Train::TrainCargo do
  let(:train_default) { Railway::Train::TrainCargo.new('101') }
  let(:train_full) { Railway::Train::TrainCargo.new('102', %w[wg1 wg2]) }

  context '#initialize' do
    specify 'тип объекта Railway::Train::CargoTrain' do
      expect(train_default).to be_an_instance_of(Railway::Train::TrainCargo)
    end

    specify 'нельзя создать поезд без номера' do
      expect { Railway::Train::TrainCargo.new }.to raise_error(ArgumentError)
    end

    specify 'только @number обязательный' do
      expect(train_default).to be_an_instance_of(Railway::Train::TrainCargo)
    end

    specify 'список вагонов пуст' do
      expect(train_default.wagons).to eq([])
    end

    specify 'список маршрутов пуст' do
      expect(train_default.route).to eq(nil)
    end

    specify 'тип поезда - :cargo' do
      expect(train_default.type).to eq(Railway::Train::Type::CARGO)
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

end

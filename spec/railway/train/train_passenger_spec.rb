# frozen_string_literal: true

require 'rspec'

describe Railway::Train::TrainPassenger do
  let(:train_default) { Railway::Train::TrainPassenger.new('101') }
  let(:train_full) { Railway::Train::TrainPassenger.new('102', %w[wg1 wg2], %w[st1 st2 st3]) }

  context '#initialize' do
    specify 'тип объекта Railway::Train::PassengerTrain' do
      expect(Railway::Train::TrainPassenger.new('100')).to be_an_instance_of(Railway::Train::TrainPassenger)
    end

    specify 'нельзя создать поезд без номера' do
      expect { Railway::Train::TrainPassenger.new }.to raise_error(ArgumentError)
    end

    specify 'только @param number обязательный' do
      expect(Railway::Train::TrainPassenger.new('100')).to be_an_instance_of(Railway::Train::TrainPassenger)
    end

    specify 'список вагонов пуст' do
      expect(train_default.wagons).to eq([])
    end

    specify 'список маршрутов пуст' do
      expect(train_default.route).to eq([])
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

    context '@param route' do
      specify 'можно указать' do
        expect(train_full.route).to eq(%w[st1 st2 st3])
      end

      specify 'тип Array' do
        expect(train_full.route).to be_an_instance_of(Array)
      end
    end
  end
end

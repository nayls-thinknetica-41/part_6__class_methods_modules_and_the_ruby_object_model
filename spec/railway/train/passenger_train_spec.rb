# frozen_string_literal: true

require 'rspec'

describe 'Railway::Train::PassengerTrain' do
  let(:train_default) { Railway::Train::PassengerTrain.new('101') }
  let(:train_full) { Railway::Train::PassengerTrain.new('102', %w[wg1 wg2], %w[st1 st2 st3]) }

  context 'по умолчанию' do
    specify 'тип объекта Railway::Train::PassengerTrain' do
      expect(Railway::Train::PassengerTrain.new('100')).to be_an_instance_of(Railway::Train::PassengerTrain)
    end

    specify 'нельзя создать поезд без номера' do
      expect { Railway::Train::PassengerTrain.new }.to raise_error(ArgumentError)
    end

    specify 'только @number обязательный' do
      expect(Railway::Train::PassengerTrain.new('100')).to be_an_instance_of(Railway::Train::PassengerTrain)
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
  end

  example 'можно указать @number' do
    expect(train_full.number).to eq('102')
  end

  example 'можно указать @wagons' do
    expect(train_full.wagons).to eq(%w[wg1 wg2])
  end

  example 'можно указать @route' do
    expect(train_full.route).to eq(%w[st1 st2 st3])
  end
end

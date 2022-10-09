# frozen_string_literal: true

require 'rspec'

describe Railway::Route do
  let(:station_st1) { Railway::Station.new('st1') }
  let(:station_st2) { Railway::Station.new('st1') }
  let(:station_st3) { Railway::Station.new('st3') }
  let(:station_st4) { Railway::Station.new('st4') }

  let(:route_default) { Railway::Route.new(station_st1, station_st2) }

  context '#initialize' do
    specify 'тип объекта Railway::Route' do
      expect(route_default).to be_an_instance_of(Railway::Route)
    end

    specify 'нельзя создать без начальной и конечной точки' do
      expect { Railway::Route.new }.to raise_error(ArgumentError)
    end

    specify 'нельзя cоздать только с начальной точкой' do
      expect { Railway::Route.new(station_st1, nil) }.to raise_error(ArgumentError)
    end

    specify 'нельзя создать только с конечной точкой' do
      expect { Railway::Route.new(nil, station_st2) }.to raise_error(ArgumentError)
    end

    example 'можно указать начальную и конечную точки' do
      expect(route_default.routes).to eq([station_st1, station_st2])
    end
  end

  context '@routes' do
    example 'выводит список маршрутов @routes' do
      expect(route_default.routes).to eq([station_st1, station_st2])
    end
  end

  context '#insert' do
    example 'можно добавить промежуточную станцию' do
      expect(
        route_default.insert(station_st3).routes
      ).to eq([station_st1, station_st3, station_st2])
    end

    example 'можно добавить сразу несколько промежуточных станций последовательно' do
      expect(
        route_default.insert(station_st3).insert(station_st4).routes
      ).to eq([station_st1, station_st3, station_st4, station_st2])
    end
  end

  context '#delete' do
    it 'можно удалить промежуточную станцию' do
      expect(
        route_default.insert(station_st3).routes
      ).to eq([station_st1, station_st3, station_st2])

      expect(
        route_default.delete(station_st3).routes
      ).to eq([station_st1, station_st2])
    end

    it 'можно удалить сразу несколько промежуточных станций последовательно' do
      expect(
        route_default.insert(station_st3).insert(station_st4).routes
      ).to eq([station_st1, station_st3, station_st4, station_st2])

      expect(
        route_default.delete(station_st3).delete(station_st4).routes
      ).to eq([station_st1, station_st2])
    end
  end
end

# frozen_string_literal: true

require 'rspec'

describe Railway::Route do
  let(:station_st1) { Railway::Station.new('st1') }
  let(:station_st2) { Railway::Station.new('st1') }
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

  context '@param routes' do
    example 'выводит список маршрутов @routes' do
      expect(route_default.routes).to eq([station_st1, station_st2])
    end
  end
end

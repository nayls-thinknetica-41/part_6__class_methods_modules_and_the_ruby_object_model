# frozen_string_literal: true

require 'rspec'

describe Railway::Station do
  let(:station_default) { Railway::Station.new('st1') }

  context '#initialize' do
    specify 'тип объекта Railway::Station' do
      expect(station_default).to be_an_instance_of(Railway::Station)
    end
  end
end

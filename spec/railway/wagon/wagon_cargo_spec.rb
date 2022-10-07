# frozen_string_literal: true

require 'rspec'

describe Railway::Wagon::WagonCargo do
  let(:wagon_default) { Railway::Wagon::WagonCargo.new }
  let(:wagon_full) { Railway::Wagon::WagonCargo.new }

  context 'по умолчанию' do
    specify 'тип объекта Railway::Wagon::WagonCargo' do
      expect(Railway::Wagon::WagonCargo.new).to be_an_instance_of(Railway::Wagon::WagonCargo)
    end

    specify 'тип вагона - :cargo' do
      expect(wagon_default.type).to eq(Railway::Wagon::Type::CARGO)
    end
  end
end

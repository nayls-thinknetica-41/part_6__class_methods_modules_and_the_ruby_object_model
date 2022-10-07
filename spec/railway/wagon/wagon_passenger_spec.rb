# frozen_string_literal: true

require 'rspec'

describe Railway::Wagon::WagonPassenger do
  let(:wagon_default) { Railway::Wagon::WagonPassenger.new }
  let(:wagon_full) { Railway::Wagon::WagonPassenger.new }

  context 'по умолчанию' do
    specify 'тип объекта Railway::Wagon::WagonPassenger' do
      expect(Railway::Wagon::WagonPassenger.new).to be_an_instance_of(Railway::Wagon::WagonPassenger)
    end

    specify 'тип вагона - :passenger' do
      expect(wagon_default.type).to eq(Railway::Wagon::Type::PASSENGER)
    end
  end
end

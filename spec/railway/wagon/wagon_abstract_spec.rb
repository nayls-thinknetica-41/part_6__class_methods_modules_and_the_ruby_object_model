# frozen_string_literal: true

require 'rspec'

describe Railway::Wagon::WagonAbstract do
  it 'нельзя создать экземпляр класса' do
    expect do
      Railway::Wagon::WagonAbstract.new
    end.to raise_error(RuntimeError, 'Cannot initialize an abstract Railway::Wagon::WagonAbstract')
  end
end

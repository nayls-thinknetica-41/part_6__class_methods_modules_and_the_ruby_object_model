# frozen_string_literal: true

require 'rspec'

describe 'Railway::Train::TrainAbstract' do
  example 'нельзя создать экземпляр класса' do
    expect do
      Railway::Train::TrainAbstract.new('100', [], [])
    end.to raise_error(RuntimeError, 'Cannot initialize an abstract Railway::Train::TrainAbstract')
  end
end

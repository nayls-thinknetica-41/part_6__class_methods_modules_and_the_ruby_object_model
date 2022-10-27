# frozen_string_literal: true

module Railway
  module Cli
    ##
    # Railway::Cli::Train
    module Train
      HELP = "Usage:\n" \
             "    train.rb train SUBCOMMAND ...\n" \
             "\n" \
             "Control subcommands:\n" \
             "    [q]uit\n" \
             "    [p]revious\n" \
             "\n" \
             "Subcommands:\n" \
             "    [c]reate\n" \
             "    [g]et\n" \
             "    [e]dit\n" \
             "    [d]elete\n" \
             "\n" \
             "Commands:\n" \
             "    [l]ist\n" \
             "\n"

      class << self
        attr_accessor :command

        def help
          puts HELP
        end

        def control(commands)
          case commands
          when 'q', 'quit'
            exit 0
          when 'p', 'previous'
            Cli::Main.help
          when 'c', 'create'
            puts '(train) >> [0] cargo, [1] passenger'
            printf '(train) >> Выберите тип поезда: '
            train_type = gets.chomp.to_i
            printf '(train) >> Введите номер поезда: '
            train_number = gets.chomp
            case train_type
            when 0
              create_trains(::Railway::Train::TrainCargo.new(train_number))
            when 1
              create_trains(::Railway::Train::TrainPassenger.new(train_number))
            else
              '(train) >> Введен неверный тип поезда'
            end
            help_and_control
          when 'g', 'get'
            printf '(train) >> Введите ID поезда: '
            train_id = gets.chomp.to_i
            get_train(train_id)
            output_and_control
          when 'e', 'edit'
            printf '(train) >> Введите ID поезда: '
            train_id = gets.chomp.to_i
            edit_trains(train_id)
            output_and_control
          when 'd', 'delete'
            printf '(train) >> Введите ID поезда: '
            train_id = gets.chomp.to_i
            delete_trains(train_id)
            output_and_control
          when 'l', 'list'
            list_trains
            output_and_control
          else
            help_and_control
          end
        end

        def get_train(train_id, format: :terminal)
          train = Cli::State.trains[train_id]

          if train.nil?
            puts '(train) >> Поезд не найден'
            return nil
          end

          if format == :terminal
            puts "[#{train_id}] #{train.number} #{train.type}"
            puts ''
          end

          train
        end

        def list_trains(format: :terminal)
          trains = Cli::State.trains

          if trains.nil?
            puts '(train) >> Нет поездов'
            return nil
          end

          if format == :terminal
            trains.each_with_index do |tr, idx|
              puts "[#{idx}] #{tr.number} #{tr.type}"
            end
            puts ''
          end

          trains
        end

        def edit_trains(train_id)
          unless Cli::State.key?(:trains)
            puts '(train) >> Нет станций'
            return nil
          end

          train = Cli::State.trains[train_id]

          if train.nil?
            puts '(train) >> Станция не найдена'
          else
            printf '(train) >> Введите новый номер поезда: '
            train.number = gets.chomp

            Cli::State.trains(train)
          end

          train
        end

        def create_trains(train)
          Cli::State.trains(train)
        end

        def delete_trains(train_id)
          unless Cli::State.key?(:trains)
            puts '(train) >> Нет поездов'
            return
          end

          if Cli::State.trains[train_id].nil?
            puts '(train) >> Поезд не найден'
          else
            Cli::State.trains.delete_at(train_id)
          end
        end

        def help_and_control
          help
          output_and_control
        end

        def output_and_control
          printf '(train) >> '
          control(gets.chomp)
        end
      end
    end
  end
end

# frozen_string_literal: true

class CpfGenerator
  def self.generate
    first_value = 0
    first_total = 0
    second_value = 0
    second_total = 0

    digit_1 = [10, 9, 8, 7, 6, 5, 4, 3, 2]

    cpf = Array.new(9) { |_i| i = rand(10) }

    9.times do |val|
      first_total = digit_1[val] * cpf[val]
      first_value += first_total
    end

    first_digit = first_value % 11

    first_digit = if first_digit < 2
                    0
                  else
                    11 - first_digit
                  end

    digit_1.push(11).sort!.reverse!

    cpf.push(first_digit)

    10.times do |value|
      second_total = digit_1[value] * cpf[value]
      second_value += second_total
    end

    second_digit = second_value % 11

    second_digit = if second_digit < 2
                     0
                   else
                     11 - second_digit
                   end

    cpf.pop

    "#{cpf.join('')}#{first_digit}#{second_digit}"
  end
end

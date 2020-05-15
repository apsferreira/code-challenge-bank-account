# frozen_string_literal: true

class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    if value.present?

      value = Crypt.decrypt(value) if Crypt.already_encrypted?(value)

      invalid = %w[12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000 12345678909]
      val = value.scan /[0-9]/

      if val.length == 11
        unless invalid.member?(val.join)
          val = val.collect(&:to_i)
          sum = 10 * val[0] + 9 * val[1] + 8 * val[2] + 7 * val[3] + 6 * val[4] + 5 * val[5] + 4 * val[6] + 3 * val[7] + 2 * val[8]
          sum -= (11 * (sum / 11))
          result = (sum == 0) || (sum == 1) ? 0 : 11 - sum

          if result == val[9]
            sum = val[0] * 11 + val[1] * 10 + val[2] * 9 + val[3] * 8 + val[4] * 7 + val[5] * 6 + val[6] * 5 + val[7] * 4 + val[8] * 3 + val[9] * 2
            sum -= (11 * (sum / 11))
            finale = (sum == 0) || (sum == 1) ? 0 : 11 - sum

            record.errors[:cpf] << "#{value} is invalid" if finale != val[10]
          end
        end
      else
        record.errors[:cpf] << "#{value} is invalid"
      end
    else
      record.errors[:cpf] << "#{value} is invalid"
    end
  end
end

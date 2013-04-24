#encoding: utf-8

class DivisibleValidator < ActiveModel::Validator
  def validate(record)    
    unless record.duration && record.duration > 0 && record.duration % 15 == 0
      record.errors[:duration] << (options[:message] || "tem que ser múltiplo de 15. (ex: 15, 30, 45, 60, 75, ...)")
    end
  end
end

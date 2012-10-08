#encoding: utf-8

class ConflictValidator < ActiveModel::Validator
  def validate(record)
    working_times = record.find_conflicts    
    working_times.each do |event|
      if working_times.id == record.id && working_times.count == 1
        return
      end
    end    
    unless working_times.blank?
      record.errors[:base] << (options[:message] || "O horário escolhido entra em conflito com outro já existente")
    end
  end
end
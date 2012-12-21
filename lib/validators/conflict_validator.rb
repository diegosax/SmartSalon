#encoding: utf-8

class ConflictValidator < ActiveModel::Validator
  def validate(record)
    working_times = record.find_conflicts  
    
    if working_times.count == 1
      if working_times.first.id == record.id
        return
      end
    end    

    unless working_times.blank?
      record.errors[:base] << (options[:message] || "O horário escolhido entra em conflito com outro já existente")
    end
  end
end
class IsBusyValidator < ActiveModel::Validator
  def validate(record)
    events = record.find_conflicts
    events.each do |event|
      if event.id == record.id && events.count == 1
        return
      end
    end
    puts "TAMANHO DOS CONFLITOSSSSSS: #{events.length}"
    unless events.blank?
      record.errors[:base] << (options[:message] || "As datas escolhidas entram em conflito com #{events.length - 1} outros agendamentos.")
    end
  end
end

class IsBusyValidator < ActiveModel::Validator
  def validate(record)
    events = Event.where(
      "
        start_at > ? and start_at < ? OR
        end_at > ? and end_at < ? OR
        start_at <= ? and end_at >= ?
      ",
      record.start_at,record.end_at,
      record.start_at,record.end_at,
      record.start_at,record.end_at
    ).all
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

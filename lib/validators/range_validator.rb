class RangeValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless object.start_at <= value
      object.errors[attribute] << (options[:message] || "nao pode ser maior que o inicio")
    end
  end
end

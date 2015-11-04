class DateParserValidator < ActiveModel::Validator
  def validate(record)
    if Chronic.parse(record.from).nil?
      record.errors[:from] << 'Could not parse the from value'
    end
    if Chronic.parse(record.to).nil?
      record.errors[:from] << 'Could not parse the to value'
    end
  end
end
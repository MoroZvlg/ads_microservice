class Ad < ApplicationRecord
  def validate
    super
    contract = AdContract.new
    result = contract.call(values)
    result.errors.to_h.each do |key, messages|
      messages.each do |message|
        errors.add(key, message)
      end
    end
  end
end
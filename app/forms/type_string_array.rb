class TypeStringArray < ActiveModel::Type::Value
  def cast_value(value)
    value
  end
end
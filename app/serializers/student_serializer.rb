class StudentSerializer < ActiveModel::Serializer
  attributes :name, :major, :age
  has_one :instructor
end

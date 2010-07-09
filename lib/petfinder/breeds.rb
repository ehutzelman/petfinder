module Petfinder

  class Breeds
    include HappyMapper
    tag 'breeds'

    has_many :breeds, String, :tag => 'breed'
  end

end
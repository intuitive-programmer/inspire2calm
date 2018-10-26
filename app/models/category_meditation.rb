class CategoryMeditation < ActiveRecord::Base
    belongs_to :category
    belongs_to :meditation
end

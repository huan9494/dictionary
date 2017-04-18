class Translation < ApplicationRecord
	serialize :discription, Array
	serialize :pictures , Array
	searchkick searchable: [:keyword]
end

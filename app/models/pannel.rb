class Pannel < ApplicationRecord
    validates :PID, :SID, :date, presence: true
end

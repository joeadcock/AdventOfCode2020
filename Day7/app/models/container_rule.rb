class ContainerRule < ApplicationRecord
  belongs_to :rule
  belongs_to :container
end

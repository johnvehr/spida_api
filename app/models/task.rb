class Task < ApplicationRecord
  belongs_to :project
  has_ancestry

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :task_tags 

  enum status: [:started,:done,:review]
  enum priority: [:high,:medium,:low]

  def date_range
    "#{self.start_date} - #{self.end_date}"
  end

end

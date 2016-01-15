class Group < ActiveRecord::Base
    has_many :children, inverse_of: :parent, class_name: 'Group', foreign_key: :parent_id
    belongs_to :parent, inverse_of: :children, class_name: 'Group', foreign_key: :parent_id
    has_many :subscriptions
    has_many :topics
    has_and_belongs_to_many :join_requirements

    def parents
      ancestry = [parent]

      while ancestry.last.try(:parent) && ancestry.size <= 10
        ancestry << ancestry.last.parent
      end
      ancestry.compact
    end

    def popular
      self.topics
    end

    def rising
      self.topics
    end

    def controversial
      self.topics
    end

end

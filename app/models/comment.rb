class Comment < ActiveRecord::Base
  belongs_to :topic

  acts_as_nested_set(
    :parent_column  => "parent_id",
    :left_column    => "left",
    :right_column   => "right",
    :scope          => "topic_id"
  )
end

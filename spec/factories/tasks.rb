FactoryBot.define do
  factory :task do
    task_title { "MyString" }
    task_desc { "MyString" }
    project { nil }
    status { 1 }
    priority { 1 }
  end
end

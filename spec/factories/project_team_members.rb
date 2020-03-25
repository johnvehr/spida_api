FactoryBot.define do
  factory :project_team_member do
    project { nil }
    user_id { 1 }
    project_access { 1 }
  end
end

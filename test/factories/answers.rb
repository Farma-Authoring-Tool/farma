FactoryBot.define do
  factory :answer do
    response { '42' }
    correct { false }
    attempt_number { 1 }
    user
    team
    solution_step
  end
end

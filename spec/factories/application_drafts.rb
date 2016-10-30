FactoryGirl.define do
  factory :application_draft do
    team

    trait :appliable do
      team { create :team, :applying_team }

      association :project1, :accepted, factory: :project
      project_plan { FFaker::Lorem.paragraph }
      heard_about_it { FFaker::Lorem.paragraph }
      why_selected_project { FFaker::Lorem.paragraph }
      working_together { FFaker::Lorem.paragraph }
      misc_info { FFaker::Lorem.paragraph } # NOTE not a required field

      after(:create) do |draft|
        draft.students.each do |student|
          student_update_attributes = (attributes_for :student, :applicant).except(*User.immutable_attributes)
          student.update(student_update_attributes)
        end
      end
    end

    trait :with_two_projects do
      association :project2, :accepted, factory: :project
    end

    trait :voluntary do
      voluntary true
      voluntary_hours_per_week 20
    end

    trait :signed_off do
      signed_off_at { Time.now.utc }
      signed_off_by { 99 }
    end
  end
end

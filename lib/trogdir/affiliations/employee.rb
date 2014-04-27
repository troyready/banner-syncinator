module Trogdir
  class Employee < Trogdir::Person
    FIELD_MAPPINGS = superclass::FIELD_MAPPINGS.merge({
      pay_type:       :pay_type,
      full_time:      :full_time,
      employee_type:  :employee_type,
      department:     :department,
      title:          :title,
      job_type:       :job_type,
      office_phone:   -> (person) { person[:phones].find{|e| e[:type] == 'office'}.try :[], :number },
      office_phone_id:      -> (person) { person[:phones].find{|p| p[:type] == 'office'} .try :[], :id }
    })
  end
end
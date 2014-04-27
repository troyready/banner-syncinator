module Banner
  class Employee < Banner::Person
    SQL = "SELECT * FROM bpv_current_employees WHERE id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"

    FIELD_MAPPINGS = superclass::FIELD_MAPPINGS.merge({
      # TODO: Not sure what to do with the commented out columns below
      pay_type:       :PAYID,
      #ecls:          :ECLS, # TODO: use to determine student_worker or employee, etc
      full_time:      -> (row) { row['FT_PT'] == 'F' },
      #employee_type:  :EMP_TYPE, # not used (I think)
      employee_type:  -> (row) { get_employee_type(row) },
      #org:           :ORG,
      department:     :ORG_DESC,
      title:          :TITLE,
      job_type:       :JOB_TYPE,
      #job_ct:        :JOB_CT,
      #fac_type:      :FAC_TYPE,
      office_phone:   :DIR_EXT,
      #alt_ext:       :ALT_EXT # TODO: create new "alternate office phone" or something type
    })

    private

    TYPE_MAP = {
      '03' => 'Student Worker',
      'P' => 'Part-Time',
      'F' => 'Full-Time',
      'O' => 'Other'
    }

    def self.get_employee_type(row)
      payid = row['PAYID']
      ft_pt = row['FT_PT']

      TYPE_MAP[payid] || TYPE_MAP[ft_pt] || "Unknown (#{ft_pt})"
    end
  end
end
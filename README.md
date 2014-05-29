Banner Syncinator [![Build Status](https://travis-ci.org/biola/banner-syncinator.svg)](https://travis-ci.org/biola/banner-syncinator)
=================

Banner Views
------------

### Alumnus

__SQL:__

```sql
SELECT i.* FROM bsv_lum_alumni_role a, bgv_personal_info i WHERE a.alumni_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | SSN | DOB | CONFID | STREET1 | STREET2 | CITY | STATE | ZIP | NATION | EMAIL | EMAIL_PERS |
|------|----|-------|-------|-------|-------|--------|-----|-----|--------|---------|---------|------|-------|-----|--------|-------|------------|

### Students

__SQL:__

```sql
SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%';
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | SSN | DOB | CONFID | STREET1 | STREET2 | CITY | STATE | ZIP | NATION | EMAIL | EMAIL_PERS |
|------|----|-------|-------|-------|-------|--------|-----|-----|--------|---------|---------|------|-------|-----|--------|-------|------------|

### Employees

__SQL:__

```sql
SELECT bpv_current_employees.* FROM bpv_current_employees WHERE id NOT LIKE 'X%' AND id NOT LIKE 'Z%'
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | CONFID | PAYID | ECLS | FT_PT | EMP_TYPE | ORG | ORG_DESC | TITLE | JOB_TYPE | JOB_CT | FAC_TYPE | DIR_EXT | ALT_EXT | PHONE | STREET1 | STREET2 | CITY | STATE | ZIP | EMAIL | NETID |
|------|----|-------|-------|-------|-------|--------|--------|-------|------|-------|----------|-----|----------|-------|----------|--------|----------|---------|---------|-------|---------|---------|------|-------|-----|-------|-------|

### Faculty

__SQL:__

```sql
SELECT i.* FROM bsv_lum_faculty_role f, bgv_personal_info i WHERE f.faculty_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | SSN | DOB | CONFID | STREET1 | STREET2 | CITY | STATE | ZIP | NATION | EMAIL | EMAIL_PERS |
|------|----|-------|-------|-------|-------|--------|-----|-----|--------|---------|---------|------|-------|-----|--------|-------|------------|

### Trustee

__SQL:__

```sql
SELECT i.* FROM bsv_lum_trustee_role t, bgv_personal_info i WHERE t.trustee_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | SSN | DOB | CONFID | STREET1 | STREET2 | CITY | STATE | ZIP | NATION | EMAIL | EMAIL_PERS |
|------|----|-------|-------|-------|-------|--------|-----|-----|--------|---------|---------|------|-------|-----|--------|-------|------------|

### Accepted Students

__SQL:__

```sql
SELECT i.* FROM bsv_lum_accepted a, bgv_personal_info i WHERE a.accepted_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'
```

__Results:__

| PIDM | ID | LNAME | FNAME | MNAME | PNAME | GENDER | SSN | DOB | CONFID | STREET1 | STREET2 | CITY | STATE | ZIP | NATION | EMAIL | EMAIL_PERS |
|------|----|-------|-------|-------|-------|--------|-----|-----|--------|---------|---------|------|-------|-----|--------|-------|------------|
Banner Syncinator [![Build Status](https://travis-ci.org/biola/banner-syncinator.svg)](https://travis-ci.org/biola/banner-syncinator)
=================

Banner Syncinator is the main source of information that gets loaded into [trogdir-api](https://github.com/biola/trogdir-api). It grabs data from various affiliation-based, and group-based views in the Banner Oracle database and makes the necessary changes in Trogdir.

Requirements
------------
- Ruby
- Redis server (for Sidekiq)
- Read access to the Biola Banner Oracle database, with custom views listed below
- trogdir-api installation

Installation
------------
```bash
git clone git@github.com:biola/banner-syncinator.git
cd banner-syncinator
bundle install
cp config/settings.local.yml.example config/settings.local.yml
cp config/blazing.rb.example config/blazing.rb
```

Configuration
-------------
- Edit `config/settings.local.yml` accordingly.
- Edit `config/blazing.rb accordingly`.

Running
-------
```bash
sidekiq -r ./config/environment.rb
```

Deployment
----------
```bash
blazing setup [target name in blazing.rb]
git push [target name in blazing.rb]
```

Basic Workflow
--------------

### Affiliations
1. Scheduled [sidetiq](https://github.com/tobiassvn/sidetiq) workers in `lib/workers/affiliations` kick of the process.
2. They call `PeopleSynchronizer.new(affiliation).sync!`
3. `PeopleSynchronizer` finds changes via `PersonCollectionComparer` and calls `PersonSynchronizer` for each changed person.
4. `PersonSynchronizer` makes changes via [`Trogdir::APIClient`](https://github.com/biola/trogdir-api-client).

_Note: `PersonCollectionComparer` uses classes in `lib/banner/affiliations` and `lib/trogdir/affiliations` to compare attributes between person records._

### Groups
1. Scheduled [sidetiq](https://github.com/tobiassvn/sidetiq) workers in `lib/workers/groups` kick of the process.
2. They call `GroupSynchronizer` with group and SQL arguments.
4. `GroupSynchronizer` makes changes via [`Trogdir::APIClient`](https://github.com/biola/trogdir-api-client).

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

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS patients (
  patient_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL CHECK(
        length(first_name) <= 35
    ),
  last_name TEXT NOT NULL CHECK(
        length(last_name) <= 35
    ),
  sex TEXT NOT NULL CHECK(
      sex = "M" OR sex = "F"
  ),
  date_of_birth TEXT NOT NULL CHECK(
      date_of_birth = strftime('%Y-%m-%d', date_of_birth)
  ),
  phone_number INTEGER UNIQUE,
  notes TEXT
);

CREATE TABLE IF NOT EXISTS appointments (
    appt_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    appt_date TEXT CHECK(
        appt_date = strftime('%Y-%m-%d %H:%M:%S', appt_date)
    ),
    appt_doctor TEXT CHECK(
        length(appt_doctor) <= 70
    ),
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS test_results (
    test_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    test_time TEXT DEFAULT CURRENT_TIMESTAMP,
    test_value REAL,
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS treatments (
    treatment_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    treatment_name TEXT,
    treatment_startdate TEXT CHECK(
        treatment_startdate = strftime('%Y-%m-%d', treatment_startdate)
    ),
    treatment_enddate TEXT CHECK(
        treatment_enddate = strftime('%Y-%m-%d', treatment_enddate)
    ),
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

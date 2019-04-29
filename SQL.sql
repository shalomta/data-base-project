CREATE TABLE Branch
(
  branchId INT NOT NULL,
  PRIMARY KEY (branchId)
);

CREATE TABLE Auditorium
(
  auditoriumId INT NOT NULL,
  PRIMARY KEY (auditoriumId)
);

CREATE TABLE Employee
(
  employeeId INT NOT NULL,
  PRIMARY KEY (employeeId)
);

CREATE TABLE MaintenanceReport
(
  seatsCondition VARCHAR(50),
  projectorCondition VARCHAR(50),
  cleanliness VARCHAR(50),
  bathroomCondition VARCHAR(50),
  reportDate DATE NOT NULL,
  maintenanceReportId INT NOT NULL,
  branchId INT NOT NULL,
  employeeId INT NOT NULL,
  PRIMARY KEY (maintenanceReportId),
  FOREIGN KEY (branchId) REFERENCES Branch(branchId),
  FOREIGN KEY (employeeId) REFERENCES Employee(employeeId)
);

CREATE TABLE Equipment
(
  equipmentName VARCHAR(20),
  equipmentId INT NOT NULL,
  branchId INT NOT NULL,
  PRIMARY KEY (equipmentId),
  FOREIGN KEY (branchId) REFERENCES Branch(branchId)
);

CREATE TABLE malfunction
(
  malfunctionId INT NOT NULL,
  description VARCHAR(200),
  isFixed INT NOT NULL,
  branchId INT NOT NULL,
  auditoriumId INT NOT NULL,
  employeeId INT NOT NULL,
  PRIMARY KEY (malfunctionId),
  FOREIGN KEY (branchId) REFERENCES Branch(branchId),
  FOREIGN KEY (auditoriumId) REFERENCES Auditorium(auditoriumId),
  FOREIGN KEY (employeeId) REFERENCES Employee(employeeId)
);

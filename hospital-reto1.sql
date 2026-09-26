-- Caso 2

CREATE TABLE RegistroHospital (
PacienteID int,
NombrePaciente varchar(100),
FechaNacimiento date,
MedicoID int,
NombreMedico varchar(100),
Especialidad varchar(100),
FechaVisita datetime,
DescripcionTratamiento varchar(255),
Medicamento varchar(100),
Dosis varchar(50)
);

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(1, 'Juan Pérez', '1985-04-12', 101, 'Dr. Carlos Ruiz', 'Cardiología', '2026-06-01 09:30:00', 'Control de presión arterial', 'Losartán', '50mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(2, 'Ana Gómez', '1990-11-23', 102, 'Dra. Laura Torres', 'Pediatría', '2026-06-01 10:15:00', 'Infección respiratoria leve', 'Amoxicilina', '500mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(3, 'Carlos Mendoza', '1975-07-05', 103, 'Dr. Miguel Ángel', 'Traumatología', '2026-06-02 11:00:00', 'Esguince de tobillo derecho', 'Ibuprofeno', '600mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(4, 'Sofía Ramírez', '2000-02-14', 104, 'Dra. Elena Vargas', 'Dermatología', '2026-06-03 15:45:00', 'Dermatitis atópica', 'Hidrocortisona', '1% crema');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(5, 'Luis Castro', '1962-09-30', 101, 'Dr. Carlos Ruiz', 'Cardiología', '2026-06-04 08:20:00', 'Arritmia leve', 'Amiodarona', '200mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(6, 'Elena Morales', '1995-12-03', 105, 'Dr. Javier Soto', 'Gastroenterología', '2026-06-04 12:00:00', 'Gastritis aguda', 'Omeprazol', '20mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(7, 'Pedro Vargas', '1988-06-19', 103, 'Dr. Miguel Ángel', 'Traumatología', '2026-06-05 16:30:00', 'Dolor lumbar crónico', 'Tramadol', '50mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(8, 'Lucía Fernández', '2005-03-25', 102, 'Dra. Laura Torres', 'Pediatría', '2026-06-06 09:00:00', 'Control de crecimiento', 'Multivitamínico', '1 tableta');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(9, 'Jorge Herrera', '1970-10-10', 106, 'Dra. Patricia Ramos', 'Neurología', '2026-06-06 11:30:00', 'Migraña tensional', 'Sumatriptán', '50mg');

INSERT INTO RegistroHospital (PacienteID, NombrePaciente, FechaNacimiento, MedicoID, NombreMedico, Especialidad, FechaVisita, DescripcionTratamiento, Medicamento, Dosis) VALUES 
(10, 'Valeria Ortiz', '1992-05-18', 104, 'Dra. Elena Vargas', 'Dermatología', '2026-06-07 14:00:00', 'Acné severo', 'Peróxido de benzoilo', '5% gel');


CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE paciente (
    PacienteID INT PRIMARY KEY,
    NombrePaciente VARCHAR(100) NOT NULL,
    FechaNacimiento DATE
);

CREATE TABLE medico (
    MedicoID INT PRIMARY KEY,
    NombreMedico VARCHAR(100) NOT NULL
);

CREATE TABLE especialidad (
    EspecialidadID INT PRIMARY KEY,
    NombreEspecialidad VARCHAR(100) NOT NULL
);

CREATE TABLE medicamento (
    MedicamentoID INT PRIMARY KEY,
    NombreMedicamento VARCHAR(100) NOT NULL
);

CREATE TABLE tratamiento (
    TratamientoID INT PRIMARY KEY,
    DescripcionTratamiento VARCHAR(255)
);

CREATE TABLE formula_medica (
    FormulaID INT PRIMARY KEY,
    FechaEmision DATE,
    MedicoID INT,
    FOREIGN KEY (MedicoID) REFERENCES medico(MedicoID)
);

CREATE TABLE especialidad_medico (
    EspecialidadMedicoID INT PRIMARY KEY,
    MedicoID INT NOT NULL,
    EspecialidadID INT NOT NULL,
    FOREIGN KEY (MedicoID) REFERENCES medico(MedicoID),
    FOREIGN KEY (EspecialidadID) REFERENCES especialidad(EspecialidadID),
    UNIQUE (MedicoID, EspecialidadID)
);

CREATE TABLE formula_medicamento (
    FormulaMedicamentoID INT PRIMARY KEY,
    FormulaID INT NOT NULL,
    MedicamentoID INT NOT NULL,
    Dosis VARCHAR(50),
    Cantidad INT,
    FOREIGN KEY (FormulaID) REFERENCES formula_medica(FormulaID),
    FOREIGN KEY (MedicamentoID) REFERENCES medicamento(MedicamentoID),
    UNIQUE (FormulaID, MedicamentoID)
);

CREATE TABLE tratamiento_formula (
    TratamientoFormulaID INT PRIMARY KEY,
    TratamientoID INT NOT NULL,
    FormulaID INT NOT NULL,
    FOREIGN KEY (TratamientoID) REFERENCES tratamiento(TratamientoID),
    FOREIGN KEY (FormulaID) REFERENCES formula_medica(FormulaID),
    UNIQUE (TratamientoID, FormulaID)
);

CREATE TABLE visita (
    VisitaID INT PRIMARY KEY,
    PacienteID INT NOT NULL,
    MedicoID INT NOT NULL,
    FechaVisita DATETIME NOT NULL,
    FOREIGN KEY (PacienteID) REFERENCES paciente(PacienteID),
    FOREIGN KEY (MedicoID) REFERENCES medico(MedicoID)
);

CREATE TABLE visita_tratamiento (
    VisitaTratamientoID INT PRIMARY KEY,
    VisitaID INT NOT NULL,
    TratamientoID INT NOT NULL,
    FOREIGN KEY (VisitaID) REFERENCES visita(VisitaID),
    FOREIGN KEY (TratamientoID) REFERENCES tratamiento(TratamientoID),
    UNIQUE (VisitaID, TratamientoID)
);

INSERT INTO paciente (PacienteID, NombrePaciente, FechaNacimiento) VALUES
(1,  'Juan Pérez',       '1985-04-12'),
(2,  'Ana Gómez',        '1990-11-23'),
(3,  'Carlos Mendoza',   '1975-07-05'),
(4,  'Sofía Ramírez',    '2000-02-14'),
(5,  'Luis Castro',      '1962-09-30'),
(6,  'Elena Morales',    '1995-12-03'),
(7,  'Pedro Vargas',     '1988-06-19'),
(8,  'Lucía Fernández',  '2005-03-25'),
(9,  'Jorge Herrera',    '1970-10-10'),
(10, 'Valeria Ortiz',    '1992-05-18');

INSERT INTO medico (MedicoID, NombreMedico) VALUES
(101, 'Dr. Carlos Ruiz'),
(102, 'Dra. Laura Torres'),
(103, 'Dr. Miguel Ángel'),
(104, 'Dra. Elena Vargas'),
(105, 'Dr. Javier Soto'),
(106, 'Dra. Patricia Ramos');

INSERT INTO especialidad (EspecialidadID, NombreEspecialidad) VALUES
(1, 'Cardiología'),
(2, 'Pediatría'),
(3, 'Traumatología'),
(4, 'Dermatología'),
(5, 'Gastroenterología'),
(6, 'Neurología');

INSERT INTO especialidad_medico (EspecialidadMedicoID, MedicoID, EspecialidadID) VALUES
(1, 101, 1),
(2, 102, 2),
(3, 103, 3),
(4, 104, 4),
(5, 105, 5),
(6, 106, 6);

INSERT INTO medicamento (MedicamentoID, NombreMedicamento) VALUES
(1,  'Losartán'),
(2,  'Amoxicilina'),
(3,  'Ibuprofeno'),
(4,  'Hidrocortisona'),
(5,  'Amiodarona'),
(6,  'Omeprazol'),
(7,  'Tramadol'),
(8,  'Multivitamínico'),
(9,  'Sumatriptán'),
(10, 'Peróxido de benzoilo');

INSERT INTO tratamiento (TratamientoID, DescripcionTratamiento) VALUES
(1,  'Control de presión arterial'),
(2,  'Infección respiratoria leve'),
(3,  'Esguince de tobillo derecho'),
(4,  'Dermatitis atópica'),
(5,  'Arritmia leve'),
(6,  'Gastritis aguda'),
(7,  'Dolor lumbar crónico'),
(8,  'Control de crecimiento'),
(9,  'Migraña tensional'),
(10, 'Acné severo');

INSERT INTO formula_medica (FormulaID, FechaEmision, MedicoID) VALUES
(1,  '2026-06-01', 101),
(2,  '2026-06-01', 102),
(3,  '2026-06-02', 103),
(4,  '2026-06-03', 104),
(5,  '2026-06-04', 101),
(6,  '2026-06-04', 105),
(7,  '2026-06-05', 103),
(8,  '2026-06-06', 102),
(9,  '2026-06-06', 106),
(10, '2026-06-07', 104);

INSERT INTO formula_medicamento (FormulaMedicamentoID, FormulaID, MedicamentoID, Dosis, Cantidad) VALUES
(1,  1,  1,  '50mg',       1),
(2,  2,  2,  '500mg',      1),
(3,  3,  3,  '600mg',      1),
(4,  4,  4,  '1% crema',   1),
(5,  5,  5,  '200mg',      1),
(6,  6,  6,  '20mg',       1),
(7,  7,  7,  '50mg',       1),
(8,  8,  8,  '1 tableta',  1),
(9,  9,  9,  '50mg',       1),
(10, 10, 10, '5% gel',     1);

INSERT INTO tratamiento_formula (TratamientoFormulaID, TratamientoID, FormulaID) VALUES
(1,  1,  1),
(2,  2,  2),
(3,  3,  3),
(4,  4,  4),
(5,  5,  5),
(6,  6,  6),
(7,  7,  7),
(8,  8,  8),
(9,  9,  9),
(10, 10, 10);

INSERT INTO visita (VisitaID, PacienteID, MedicoID, FechaVisita) VALUES
(1,  1,  101, '2026-06-01 09:30:00'),
(2,  2,  102, '2026-06-01 10:15:00'),
(3,  3,  103, '2026-06-02 11:00:00'),
(4,  4,  104, '2026-06-03 15:45:00'),
(5,  5,  101, '2026-06-04 08:20:00'),
(6,  6,  105, '2026-06-04 12:00:00'),
(7,  7,  103, '2026-06-05 16:30:00'),
(8,  8,  102, '2026-06-06 09:00:00'),
(9,  9,  106, '2026-06-06 11:30:00'),
(10, 10, 104, '2026-06-07 14:00:00');

INSERT INTO visita_tratamiento (VisitaTratamientoID, VisitaID, TratamientoID) VALUES
(1,  1,  1),
(2,  2,  2),
(3,  3,  3),
(4,  4,  4),
(5,  5,  5),
(6,  6,  6),
(7,  7,  7),
(8,  8,  8),
(9,  9,  9),
(10, 10, 10);




USE master;
GO
IF DB_ID('empresa') IS NOT NULL
BEGIN
    ALTER DATABASE empresa SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE empresa;
END
GO
CREATE DATABASE empresa;
GO
USE empresa;
GO

CREATE TABLE Departamento (
    Id_Departamento   INT          NOT NULL,
    Nombre_Dep        VARCHAR(30)  NOT NULL,
    Descripcion_Dep   VARCHAR(50)  NULL,
    CONSTRAINT PK_Departamento PRIMARY KEY (Id_Departamento)
);
GO

CREATE TABLE Empleado (
    Id_Empleado       INT          NOT NULL,
    Nombre_Emp        VARCHAR(30)  NOT NULL,
    ApellidoPat_Emp   VARCHAR(30)  NOT NULL,
    ApellidoMat_Emp   VARCHAR(30)  NULL,
    Telefono_Emp      INT          NULL,
    Direccion_Emp     VARCHAR(30)  NULL,
    Sueldo_Emp        INT          NULL,
    Id_Departamento   INT          NOT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (Id_Empleado),
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (Id_Departamento)
        REFERENCES Departamento (Id_Departamento)
);
GO

INSERT INTO Departamento (Id_Departamento, Nombre_Dep, Descripcion_Dep) 
VALUES
(1,  'Recursos Humanos', 'Gestion de personal y contratacion'),
(2,  'Contabilidad',     'Control financiero y contable'),
(3,  'Ventas',           'Venta de productos y atencion a clientes'),
(4,  'Sistemas',         'Soporte tecnico y desarrollo'),
(5,  'Marketing',        'Publicidad y promocion de la empresa'),
(6,  'Logistica',        'Almacen y distribucion'),
(7,  'Compras',          'Adquisicion de insumos y materiales'),
(8,  'Produccion',       'Fabricacion de productos'),
(9,  'Calidad',          'Control y aseguramiento de la calidad'),
(10, 'Direccion',        'Administracion general de la empresa');
GO

INSERT INTO Empleado (Id_Empleado, Nombre_Emp, ApellidoPat_Emp, 
ApellidoMat_Emp, Telefono_Emp, Direccion_Emp, Sueldo_Emp, 
Id_Departamento) VALUES
(101, 'Juan',    'Perez',    'Lopez',      81234567, 'Av. Juarez 123',       12000, 1),
(102, 'Maria',   'Garcia',   'Hernandez',  82345678, 'Calle Hidalgo 45',     15000, 2),
(103, 'Carlos',  'Martinez', 'Ramirez',    83456789, 'Av. Reforma 780',      11000, 3),
(104, 'Ana',     'Lopez',    'Torres',     84567890, 'Calle Morelos 90',     10000, 4),
(105, 'Luis',    'Gonzalez', 'Flores',     85678901, 'Av. Constitucion 5',   13500, 3),
(106, 'Sofia',   'Ramirez',  'Cruz',       86789012, 'Calle Juarez 321',     14000, 5),
(107, 'Pedro',   'Sanchez',  'Mendoza',    87890123, 'Av. Madero 66',        10500, 6),
(108, 'Laura',   'Torres',   'Ortiz',      88901234, 'Calle Allende 12',     16000, 7),
(109, 'Miguel',  'Flores',   'Reyes',      89012345, 'Av. Universidad 400',  12500, 8),
(110, 'Daniela', 'Cruz',     'Vargas',     80123456, 'Calle Zaragoza 77',    20000, 10);
GO

SELECT * FROM Departamento;
SELECT * FROM Empleado;
GO

SELECT Nombre_Emp, ApellidoPat_Emp, Sueldo_Emp
FROM Empleado
WHERE Sueldo_Emp > 13000;
GO

UPDATE Empleado
SET Sueldo_Emp = 17000
WHERE Id_Empleado = 101;

UPDATE Empleado
SET Direccion_Emp = 'Calle Nueva 100'
WHERE Id_Empleado = 107;
GO

DELETE FROM Empleado
WHERE Id_Empleado = 109;
GO

DELETE FROM Departamento
WHERE Id_Departamento = 9;
GO

SELECT
    E.Nombre_Emp      AS Nombre,
    E.ApellidoPat_Emp AS Apellido,
    E.Sueldo_Emp      AS Sueldo,
    D.Nombre_Dep      AS Departamento
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento;
GO

SELECT
    D.Nombre_Dep       AS Departamento,
    COUNT(E.Id_Empleado) AS Total_Empleados,
    SUM(E.Sueldo_Emp)  AS Total_Sueldos
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento
GROUP BY D.Nombre_Dep;
GO

SELECT Nombre_Emp, ApellidoPat_Emp, Sueldo_Emp
FROM Empleado
ORDER BY Sueldo_Emp ASC;

SELECT Nombre_Emp, ApellidoPat_Emp, Sueldo_Emp
FROM Empleado
ORDER BY Sueldo_Emp DESC;

SELECT
    D.Nombre_Dep       AS Departamento,
    SUM(E.Sueldo_Emp)  AS Total_Sueldos
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento
GROUP BY D.Nombre_Dep
ORDER BY Total_Sueldos DESC;
GO

SELECT CAST(AVG(CAST(Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Sueldo
FROM Empleado;
GO

SELECT
    CAST(AVG(CAST(Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Sueldo,
    MAX(Sueldo_Emp) AS Sueldo_Maximo,
    MIN(Sueldo_Emp) AS Sueldo_Minimo
FROM Empleado;
GO

SELECT
    D.Nombre_Dep AS Departamento,
    COUNT(E.Id_Empleado) AS Total_Empleados,
    CAST(AVG(CAST(E.Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Sueldo
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento
GROUP BY D.Nombre_Dep
ORDER BY Promedio_Sueldo DESC;
GO

SELECT
    D.Nombre_Dep AS Departamento,
    CAST(AVG(CAST(E.Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Sueldo
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento
GROUP BY D.Nombre_Dep
HAVING AVG(CAST(E.Sueldo_Emp AS DECIMAL(10,2))) > 12000
ORDER BY Promedio_Sueldo DESC;
GO

SELECT Nombre_Emp, ApellidoPat_Emp, Sueldo_Emp
FROM Empleado
WHERE Sueldo_Emp > (SELECT AVG(Sueldo_Emp) FROM Empleado)
ORDER BY Sueldo_Emp DESC;
GO

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE Nombre_Emp LIKE 'M%';

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE ApellidoPat_Emp LIKE '%ez';

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE ApellidoPat_Emp LIKE '%or%';

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE Nombre_Emp LIKE '_a%';

SELECT Nombre_Emp, Direccion_Emp
FROM Empleado
WHERE Direccion_Emp LIKE 'Av.%';

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE Nombre_Emp LIKE '[A-L]%';

SELECT Nombre_Emp, ApellidoPat_Emp
FROM Empleado
WHERE ApellidoPat_Emp NOT LIKE '%ez';

SELECT Nombre_Dep, Descripcion_Dep
FROM Departamento
WHERE Nombre_Dep LIKE '%ion%';
GO

SELECT CAST(AVG(CAST(Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Apellidos_ez
FROM Empleado
WHERE ApellidoPat_Emp LIKE '%ez';
GO

SELECT
    D.Nombre_Dep AS Departamento,
    COUNT(E.Id_Empleado) AS Total_Empleados,
    CAST(AVG(CAST(E.Sueldo_Emp AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Promedio_Sueldo
FROM Empleado AS E
INNER JOIN Departamento AS D
    ON E.Id_Departamento = D.Id_Departamento
WHERE E.Direccion_Emp LIKE 'Av.%'
GROUP BY D.Nombre_Dep
ORDER BY Promedio_Sueldo DESC;
GO

CREAT DATABASE COMATEQ001;

CREATE TABLE `Universidad` (
  `id_universidad` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `pais` VARCHAR(255)
);

CREATE TABLE `Coordinador` (
  `id_coordinador` INT PRIMARY KEY AUTO_INCREMENT,
  `primer_nombre` VARCHAR(255),
  `segundo_nombre` VARCHAR(255),
  `primer_apellido` VARCHAR(255),
  `segundo_apellido` VARCHAR(255),
  `email` VARCHAR(255),
  `universidad` INT,
  `permiso` INT
);

CREATE TABLE `Equipo` (
  `id_equipo` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `ano_de_participacion` INT,
  `temporada_de_ano` VARCHAR(255),
  `coordinador` INT,
  `universidad` INT,
  `puntuacion` INT,
  `medalla_pais` INT COMMENT '1 = oro, 2 = plata, 3 = bronce',
  `medalla_region` INT COMMENT '1 = oro, 2 = plata, 3 = bronce',
  `medalla_universidad` INT COMMENT '1 = oro, 2 = plata, 3 = bronce'
);

CREATE TABLE `Estudiante` (
  `id_estudiante` INT PRIMARY KEY AUTO_INCREMENT,
  `primer_nombre` VARCHAR(255),
  `segundo_nombre` VARCHAR(255),
  `primer_apellido` VARCHAR(255),
  `segundo_apellido` VARCHAR(255),
  `escuela` VARCHAR(255),
  `grado` int,
  `fecha_de_nacimiento` DATE,
  `permiso` INT
);

CREATE TABLE `Escuela` (
  `id_escuela` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `numero_de_telefono` varchar(255),
  `email` varchar(255),
  `pais` VARCHAR(255)
);

CREATE TABLE `Participacion` (
  `id_equipo` INT,
  `e1` INT,
  `e2` INT,
  `e3` INT,
  PRIMARY KEY (`id_equipo`, `e1`, `e2`, `e3`)
);

CREATE TABLE `Problema` (
  `id_problema` INT PRIMARY KEY AUTO_INCREMENT,
  `tipo` VARCHAR(255),
  `descripcion` text,
  `solucion` text,
  `coordinador_proponente` INT,
  `universidad_proponente` INT
);

CREATE TABLE `Olimpiada_Regional` (
  `id_olimp` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `url` VARCHAR(255),
  `logo` VARCHAR(255),
  `coordinador` INT,
  `universidad` INT
);

CREATE TABLE `Administradores` (
  `id_admin` INT PRIMARY KEY AUTO_INCREMENT,
  `primer_nombre` VARCHAR(255),
  `segundo_nombre` VARCHAR(255),
  `primer_apellido` VARCHAR(255),
  `segundo_apellido` VARCHAR(255),
  `email` VARCHAR(255),
  `universidad` INT,
  `posicion_en_organizacion` VARCHAR(255),
  `permiso` INT
);

CREATE TABLE `Examen` (
  `id_examen` INT PRIMARY KEY AUTO_INCREMENT,
  `prob_lib_1` INT,
  `prob_lib_2` INT,
  `prob_lib_3` INT,
  `prob_lib_4` INT,
  `prob_mult_1` INT,
  `prob_mult_2` INT,
  `prob_mult_3` INT,
  `prob_mult_4` INT,
  `prob_mult_5` INT,
  `prob_mult_6` INT,
  `prob_mult_7` INT,
  `prob_mult_8` INT,
  `usado_en` DATE
);

CREATE TABLE `Permiso` (
  `id_permiso` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255)
);

ALTER TABLE `Universidad` ADD FOREIGN KEY (`id_universidad`) REFERENCES `Coordinador` (`universidad`);

ALTER TABLE `Permiso` ADD FOREIGN KEY (`id_permiso`) REFERENCES `Coordinador` (`permiso`);

ALTER TABLE `Coordinador` ADD FOREIGN KEY (`id_coordinador`) REFERENCES `Equipo` (`coordinador`);

ALTER TABLE `Coordinador` ADD FOREIGN KEY (`universidad`) REFERENCES `Equipo` (`universidad`);

ALTER TABLE `Escuela` ADD FOREIGN KEY (`id_escuela`) REFERENCES `Estudiante` (`escuela`);

ALTER TABLE `Permiso` ADD FOREIGN KEY (`id_permiso`) REFERENCES `Estudiante` (`permiso`);

ALTER TABLE `Participacion` ADD FOREIGN KEY (`id_equipo`) REFERENCES `Equipo` (`id_equipo`);

CREATE TABLE `Estudiante_Participacion` (
  `Estudiante_id_estudiante` INT,
  `Participacion_e1` INT,
  PRIMARY KEY (`Estudiante_id_estudiante`, `Participacion_e1`)
);

ALTER TABLE `Estudiante_Participacion` ADD FOREIGN KEY (`Estudiante_id_estudiante`) REFERENCES `Estudiante` (`id_estudiante`);

ALTER TABLE `Estudiante_Participacion` ADD FOREIGN KEY (`Participacion_e1`) REFERENCES `Participacion` (`e1`);


CREATE TABLE `Estudiante_Participacion(1)` (
  `Estudiante_id_estudiante` INT,
  `Participacion_e2` INT,
  PRIMARY KEY (`Estudiante_id_estudiante`, `Participacion_e2`)
);

ALTER TABLE `Estudiante_Participacion(1)` ADD FOREIGN KEY (`Estudiante_id_estudiante`) REFERENCES `Estudiante` (`id_estudiante`);

ALTER TABLE `Estudiante_Participacion(1)` ADD FOREIGN KEY (`Participacion_e2`) REFERENCES `Participacion` (`e2`);


CREATE TABLE `Estudiante_Participacion(2)` (
  `Estudiante_id_estudiante` INT,
  `Participacion_e3` INT,
  PRIMARY KEY (`Estudiante_id_estudiante`, `Participacion_e3`)
);

ALTER TABLE `Estudiante_Participacion(2)` ADD FOREIGN KEY (`Estudiante_id_estudiante`) REFERENCES `Estudiante` (`id_estudiante`);

ALTER TABLE `Estudiante_Participacion(2)` ADD FOREIGN KEY (`Participacion_e3`) REFERENCES `Participacion` (`e3`);


ALTER TABLE `Coordinador` ADD FOREIGN KEY (`id_coordinador`) REFERENCES `Problema` (`coordinador_proponente`);

ALTER TABLE `Coordinador` ADD FOREIGN KEY (`universidad`) REFERENCES `Problema` (`universidad_proponente`);

ALTER TABLE `Coordinador` ADD FOREIGN KEY (`id_coordinador`) REFERENCES `Olimpiada_Regional` (`coordinador`);

ALTER TABLE `Coordinador` ADD FOREIGN KEY (`universidad`) REFERENCES `Olimpiada_Regional` (`universidad`);

ALTER TABLE `Universidad` ADD FOREIGN KEY (`id_universidad`) REFERENCES `Administradores` (`universidad`);

ALTER TABLE `Permiso` ADD FOREIGN KEY (`id_permiso`) REFERENCES `Administradores` (`permiso`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_lib_1`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_lib_2`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_lib_3`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_lib_4`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_1`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_2`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_3`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_4`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_5`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_6`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_7`);

ALTER TABLE `Problema` ADD FOREIGN KEY (`id_problema`) REFERENCES `Examen` (`prob_mult_8`);

-- TRIGGERT START

CREATE TRIGGER antes_de_insertar_equipo
BEFORE INSERT ON Equipo
FOR EACH ROW
Begin

  -- Variables que guardaran los segmentos necesarios para crear el nombre del quipos
  DECLARE uni_nombre VARCHAR(255);
  DECLARE comp_year INT;
  DECLARE season VARCHAR(255)

  -- Obten el nombre de la universidad
  SELECT nombre INTO uni_nombre FROM Universidad WHERE id_universidad = NEW.id_universidad;

  -- Obten el año de la competencia
  SELECT ano_de_participacion INTO comp_year FROM Equipo WHERE id_equipo = NEW.id_equipo;

  -- Obten la temporada de la competencia
  SELECT temporada_de_ano INTO season FROM Equipo WHERE id_equipo = NEW.id_equipo;

  -- Establece el nombre del equipo como la concatenacion de la universidad, id del equipo, año y temporada
  SET NEW.nombre = CONCAT(uni_nombre, NEW.id_equipo, '_', comp_year, '_', season);


-- TRIGGER END
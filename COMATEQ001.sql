CREATE TABLE `Universidad` (
  `id_universidad` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `pais` VARCHAR(255)
);

CREATE TABLE `Permiso` (
  `id_permiso` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255)
);

CREATE TABLE `Coordinador` (
  `id_coordinador` INT PRIMARY KEY AUTO_INCREMENT,
  `primer_nombre` VARCHAR(255),
  `segundo_nombre` VARCHAR(255),
  `primer_apellido` VARCHAR(255),
  `segundo_apellido` VARCHAR(255),
  `email` VARCHAR(255),
  `universidad` INT,
  `permiso` INT COMMENT '0 = nada, 1 = admin, 2 = coordinador, 3 = estudiante, 4 = todo el mundo',
  FOREIGN KEY (`universidad`) REFERENCES `Universidad`(`id_universidad`),
  FOREIGN KEY (`permiso`) REFERENCES `Permiso`(`id_permiso`)
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
  `medalla_universidad` INT COMMENT '1 = oro, 2 = plata, 3 = bronce',
  FOREIGN KEY (`coordinador`) REFERENCES `Coordinador`(`id_coordinador`),
  FOREIGN KEY (`universidad`) REFERENCES `Universidad`(`id_universidad`)
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
  `permiso` INT COMMENT '0 = nada, 1 = admin, 2 = coordinador, 3 = estudiante, 4 = todo el mundo',
  FOREIGN KEY (`permiso`) REFERENCES `Permiso`(`id_permiso`)
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
  `id_estudiante` INT,
  PRIMARY KEY (`id_equipo`, `id_estudiante`),
  FOREIGN KEY (`id_equipo`) REFERENCES `Equipo`(`id_equipo`),
  FOREIGN KEY (`id_estudiante`) REFERENCES `Estudiante`(`id_estudiante`)
);

CREATE TABLE `Problema` (
  `id_problema` INT PRIMARY KEY AUTO_INCREMENT,
  `tipo` VARCHAR(255),
  `descripcion` text,
  `solucion` text,
  `coordinador_proponente` INT,
  `universidad_proponente` INT,
  FOREIGN KEY (`coordinador_proponente`) REFERENCES `Coordinador`(`id_coordinador`),
  FOREIGN KEY (`universidad_proponente`) REFERENCES `Universidad`(`id_universidad`)
);

CREATE TABLE `Olimpiada_Regional` (
  `id_olimp` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(255),
  `url` VARCHAR(255),
  `logo` VARCHAR(255),
  `coordinador` INT,
  `universidad` INT,
  FOREIGN KEY (`coordinador`) REFERENCES `Coordinador`(`id_coordinador`),
  FOREIGN KEY (`universidad`) REFERENCES `Universidad`(`id_universidad`)
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
  `permiso` INT COMMENT '0 = nada, 1 = admin, 2 = coordinador, 3 = estudiante, 4 = todo el mundo',
  `password_hash` VARCHAR(255) COMMENT `No es la contraseña, sino el hash de ella.`
  FOREIGN KEY (`universidad`) REFERENCES `Universidad`(`id_universidad`),
  FOREIGN KEY (`permiso`) REFERENCES `Permiso`(`id_permiso`)
);

CREATE TABLE `Examen` (
  `id_examen` INT PRIMARY KEY AUTO_INCREMENT,
  `usado_en` DATE
);

CREATE TABLE `problemas_en_examen` (
  `id_examen` int,
  `id_problema` int,
  `posicion` int COMMENT 'Campo opcional para definir el orden de los problemas en el examen',
  PRIMARY KEY (`id_examen`, `id_problema`),
  FOREIGN KEY (`id_examen`) REFERENCES `Examen`(`id_examen`),
  FOREIGN KEY (`id_problema`) REFERENCES `Problema`(`id_problema`)
);

-- Claves foráneas adicionales para tablas existentes
ALTER TABLE `Escuela` ADD FOREIGN KEY (`id_escuela`) REFERENCES `Estudiante` (`id_estudiante`);

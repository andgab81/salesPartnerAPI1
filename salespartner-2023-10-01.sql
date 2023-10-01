-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gazdă: 127.0.0.1
-- Timp de generare: oct. 01, 2023 la 04:53 PM
-- Versiune server: 10.4.28-MariaDB
-- Versiune PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Bază de date: salespartner
--
CREATE DATABASE IF NOT EXISTS salespartner DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE salespartner;

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel alocari
--

CREATE TABLE alocari (
  id int(5) NOT NULL,
  id_lead int(5) NOT NULL,
  id_vanzator int(5) NOT NULL,
  status varchar(20) NOT NULL DEFAULT 'NOU',
  data_status timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel alocari
--

INSERT INTO alocari (id, id_lead, id_vanzator, status, data_status) VALUES
(1, 1, 3, 'NOU', '2023-09-29 13:17:10'),
(2, 2, 5, 'NOU', '2023-09-29 13:18:04'),
(3, 3, 2, 'NOU', '2023-09-29 13:20:56');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel clienti
--

CREATE TABLE clienti (
  id int(5) NOT NULL,
  nume varchar(30) NOT NULL,
  prenume varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  telefon varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel clienti
--

INSERT INTO clienti (id, nume, prenume, email, telefon) VALUES
(1, 'Ghita', 'Lorin', 'zmartin@example.com', '0339620248'),
(2, 'Dinu', 'Axinte', 'florența82@example.net', '0256006791'),
(3, 'Andrei', 'Gabriel', 'gabriel.andrei@gmail.com', '0741292825');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel leads
--

CREATE TABLE leads (
  id int(5) NOT NULL,
  id_client int(5) NOT NULL,
  mesaj text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel leads
--

INSERT INTO leads (id, id_client, mesaj) VALUES
(1, 1, 'Officiis illum nobis libero totam et non. Perferendis vero pariatur ullam eum. Ut atque cum laboriosam sit. Qui sint sapiente possimus assumenda.'),
(2, 2, 'Alias eos animi perferendis enim. Nulla reiciendis cumque cumque ducimus cum architecto vero alias. Ipsum aut quia rerum vero.'),
(3, 1, 'Sed ut omnis cupiditate rerum odit nostrum. Quibusdam laboriosam nihil iste sint deserunt. Non officiis dolorem vel iure.'),
(4, 3, 'Vreau o masina MercedesBenz'),
(5, 3, 'Vreau o masina BMW second-hand');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel masini
--

CREATE TABLE masini (
  id int(5) NOT NULL,
  introdus timestamp NOT NULL DEFAULT current_timestamp(),
  marca varchar(50) NOT NULL DEFAULT 'Mercedes-Benz',
  model varchar(50) NOT NULL,
  submodel varchar(25) DEFAULT NULL,
  transmisie enum('automata','manuala') NOT NULL,
  tractiune enum('fata','spate','4x4') NOT NULL,
  combustibil enum('electric','hibrid','benzina','motorina') NOT NULL,
  putere int(5) NOT NULL,
  km int(7) NOT NULL,
  tip_stoc enum('nou','utilizat') NOT NULL,
  pret_eur_fara_tva int(7) NOT NULL DEFAULT 0,
  culoare_interior varchar(20) NOT NULL,
  culoare_exterior varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel masini
--

INSERT INTO masini (id, introdus, marca, model, submodel, transmisie, tractiune, combustibil, putere, km, tip_stoc, pret_eur_fara_tva, culoare_interior, culoare_exterior) VALUES
(4, '2023-09-01 11:34:53', 'Mercedes-Benz', 'EQE', 'Mercedes-AMG43 4MATIC', 'automata', '4x4', 'electric', 476, 5, 'nou', 50000, '', 'Gri'),
(5, '2023-09-15 11:34:53', 'Mercedes-Benz', 'EQB', '300 4MATIC', 'automata', '4x4', 'electric', 228, 3, 'nou', 130000, '', 'Gri'),
(6, '2023-10-01 11:34:53', 'Mercedes-Benz', 'EQA', '250', 'automata', 'fata', 'electric', 190, 12993, 'utilizat', 45000, '', 'Galben/Auriu');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel vanzatori
--

CREATE TABLE vanzatori (
  id int(5) NOT NULL,
  nume varchar(45) NOT NULL,
  prenume varchar(45) NOT NULL,
  ocupat tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel vanzatori
--

INSERT INTO vanzatori (id, nume, prenume, ocupat) VALUES
(1, 'David', 'Gabi', 0),
(2, 'Sima', 'Axinte', 0),
(3, 'Marginean', 'Teodor', 0),
(4, 'Chirila', 'Costin', 0),
(5, 'Pascu', 'Marcheta', 0);

--
-- Indexuri pentru tabele eliminate
--

--
-- Indexuri pentru tabele alocari
--
ALTER TABLE alocari
  ADD PRIMARY KEY (id);

--
-- Indexuri pentru tabele clienti
--
ALTER TABLE clienti
  ADD PRIMARY KEY (id);

--
-- Indexuri pentru tabele leads
--
ALTER TABLE leads
  ADD PRIMARY KEY (id);

--
-- Indexuri pentru tabele masini
--
ALTER TABLE masini
  ADD PRIMARY KEY (id);

--
-- Indexuri pentru tabele vanzatori
--
ALTER TABLE vanzatori
  ADD PRIMARY KEY (id);

--
-- AUTO_INCREMENT pentru tabele eliminate
--

--
-- AUTO_INCREMENT pentru tabele alocari
--
ALTER TABLE alocari
  MODIFY id int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pentru tabele clienti
--
ALTER TABLE clienti
  MODIFY id int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pentru tabele leads
--
ALTER TABLE leads
  MODIFY id int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pentru tabele masini
--
ALTER TABLE masini
  MODIFY id int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pentru tabele vanzatori
--
ALTER TABLE vanzatori
  MODIFY id int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

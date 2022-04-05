/* Stworzenie tabeli Users */
CREATE TABLE Users ( 
   Id int IDENTITY(1,1) PRIMARY KEY, 
   FirstName VARCHAR(255) NOT NULL, 
   LastName  VARCHAR(255),
   Email     VARCHAR(255) NOT NULL,
   Age       int
);
 
/* Stworzenie tabeli Expenses - Wydatki */
CREATE TABLE Expenses ( 
   Id INT IDENTITY(1,1) PRIMARY KEY, 
   UserId         INT,
   Title  	      VARCHAR(255) NOT NULL, 
   Description    VARCHAR(255),
   Price          DECIMAL(10,2) NOT NULL,
   StoreName      VARCHAR(255),
   Date           datetime2
);

/* Stworzenie relacji pomiędzy użytkownikiem a wydatkami. Jeden użytkownik może mieć wiele wydatków */
ALTER TABLE Expenses
ADD CONSTRAINT FK_UserExpense
FOREIGN KEY (UserId) REFERENCES Users(Id);

INSERT INTO Users (FirstName, LastName, Email, Age)
VALUES 
('Filip', 'Paluch', 'filip@o2.pl', null),
('Damian', 'Krychowski', 'damian@gmail.com', 31);

INSERT INTO Expenses (UserId, Title, Description, Price, StoreName, Date)
VALUES 
(1 /* FILIP */, 'Maslo', null, 5.99, 'Lidl', '2022-03-09 12:34:11'),
(1 /* FILIP */, 'Chleb', null, 4.80, 'Lidl', '2022-03-09 12:34:11'),
(1 /* FILIP */, 'Szynka', null, 40.39, 'Lidl', '2022-03-09 12:34:11'),
(1 /* FILIP */, 'Sól', null, 2.00, 'Lidl', '2022-03-04 06:21:11'),
(1 /* FILIP */, 'Sok', 'Dla Adama', 3.78, 'Biedronka', '2022-03-06 10:46:20'),
(1 /* FILIP */, 'Woda Mineralna', null, 1.20, 'Biedronka', '2022-03-06 10:46:20'),
(1 /* FILIP */, 'Mięso', null, 25.87, 'Biedronka', '2022-03-06 10:46:20'),
(1 /* FILIP */, 'Pomidory', null, 12.99, 'Biedronka', '2022-03-06 10:46:20'),
(1 /* FILIP */, 'Papryka', null, 14.99, null, '2022-03-07 09:59:20'),
(1 /* FILIP */, 'Banany', null, 8.99, null, '2022-03-07 09:59:20'),
(1 /* FILIP */, 'Mięso', null, 45.87, 'Sklep mięsny PROSIACZEK', '2022-03-05 12:46:20'),

(2 /* Damian */, 'Mięso', null, 35.87, 'Lidl', '2022-03-05 10:46:20'),
(2 /* Damian */, 'Pomidory', null, 14.99, 'Lidl', '2022-03-06 07:30:20'),
(2 /* Damian */, 'Gruszki', null, 3.99, 'Biedronka', '2022-03-07 08:59:20'),
(2 /* Damian */, 'Mięso', null, 87.99, 'Sklep mięsny PROSIACZEK', '2022-03-07 09:59:20'),
(2 /* Damian */, 'Mięso', null, 37.99, null, '2022-02-07 09:59:20'),
(2 /* Damian */, 'Mięso', null, 67.99, 'Sklep mięsny PROSIACZEK', '2022-01-07 09:59:20'),
(2 /* Damian */, 'Płatki', 'Zakupy dla rodziców', 5.99, 'Lidl', '2022-01-03 09:59:20'),
(2 /* Damian */, 'Mydło', 'Zakupy dla rodziców', 7.99, 'Lidl', '2022-01-03 09:59:20');

--ZADANIA

/* 1. Wypisz wszystkie wydatki z tabeli Expenses które powiązane są z użytkownikiem 'Filip'
   w kolejności od najnowszych do najstarszych */

SELECT * 
FROM Expenses 
WHERE userid = 1 
ORDER BY date DESC
   
/*  2. Wypisz wszystkie wydatki użytkownika 'Filip' i 'Damian' które zostały wykonane w sklepie 'Lidl' */

SELECT * 
FROM Expenses 
WHERE storename = 'Lidl' AND userid = 1 OR storename = 'Lidl' AND userid = 2
   
/*  3. Wypisz jaka jest cena najdroższego wydatku dla użytkownika 'Filip' */

SELECT TOP 1 price 
FROM Expenses
WHERE userid = 1
ORDER BY price DESC
   
/*  4. Podlicz i wypisz ile sumarycznie wydał użytkownik 'Damian' na mięso w miesiącu 'Marzec' */

SELECT SUM(price)
from Expenses
where userid = 2
   
/*  5.  Wypisz wszystkie wydatki wszystkich użytkowników które mają dodany opis */

SELECT *
from Expenses
where description IS NOT null
   
/*  6. Podlicz i wypisz ile średnio wydawał użytkownik 'Damian' na mięso */

SELECT AVG(price)
from Expenses
where title = 'Mięso' AND userid = 2
   
/*  7. Podlicz i wypisz za pomocą jednego zapytania ile wydał łącznie Filip oraz Damian dnia 07.03.2022.
      Wypisz wynik w postaci dwóch kolumn: Użytkownik, Kwota. */

SELECT userid, SUM(price)
from Expenses
group by userid
   
/* Zadania z *
   
/* 6. Wypisz wszytkie wydatki wszystkich użytkowników łączac dane z tabeli Expenses z danymi z tabeli 
      Users za pomocą komendy JOIN - w formie:
      FirstName, LastName, Title, Price */

SELECT Users.firstname, Users.lastname, Expenses.title, Expenses.price
FROM Users
INNER JOIN  Expenses ON  Users.id = Expenses.UserId

   
/*  7. Podlicz i wypisz ile średnio wydaje Damian i Filip w każdym miesiącu na mięso */




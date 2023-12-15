-- El dueño de una clínica de fisioterapia quiere que los datos de su empresa sean gestionados
-- y organizados de la manera más eficiente posible.

DROP DATABASE IF EXISTS FISIOTERAPIA;
CREATE DATABASE FISIOTERAPIA;
\c FISIOTERAPIA;

-- Instrucciones de borrado de tablas para su nueva construcción
DROP TABLE IF EXISTS fisioterapeuta CASCADE;
DROP TABLE IF EXISTS paciente CASCADE;
DROP TABLE IF EXISTS cita CASCADE;

-- Fisioterapeuta
CREATE TABLE fisioterapeuta
(
    id_fisio SERIAL,
    apellidos varchar(50),
    nombre varchar(30)
);

ALTER TABLE fisioterapeuta
    ADD CONSTRAINT PK_fisioterapeuta PRIMARY KEY(id_fisio);

-- Paciente
CREATE TABLE paciente
(
    id_paciente int,
    apellidos varchar(50),
    nombre varchar(30),
    peso float,
    altura_cm int,
    fecha_nacimiento date
);

ALTER TABLE paciente
    ADD CONSTRAINT PK_paciente PRIMARY KEY(id_paciente);

-- Asociación Fisioterapeuta-Paciente: Cita
CREATE TABLE cita
(
    id_fisio int,
    id_paciente int,
    fecha timestamp,
    numero_consulta int
);

ALTER TABLE cita
    ADD CONSTRAINT PK_cita PRIMARY KEY(id_fisio,id_paciente);
ALTER TABLE cita
    ADD CONSTRAINT FK_fisio FOREIGN KEY(id_fisio) REFERENCES fisioterapeuta(id_fisio);
ALTER TABLE cita
    ADD CONSTRAINT FK_paciente FOREIGN KEY(id_paciente) REFERENCES paciente(id_paciente);


INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Hudson','Quon'),
    ('Mcpherson','Miriam'),
    ('Tanner','Delilah'),
    ('Bowers','Cynthia'),
    ('Sexton','Kameko'),
    ('Alston','Darryl'),
    ('Roberson','Erin'),
    ('Bradford','Raphael'),
    ('Contreras','Idola'),
    ('Miller','Ross');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Anthony','Julie'),
    ('Gallegos','Xanthus'),
    ('Richard','Desiree'),
    ('Chen','Macey'),
    ('Gay','Cairo'),
    ('Warner','Vladimir'),
    ('Baird','Abdul'),
    ('Johnson','Salvador'),
    ('Spears','Jason'),
    ('Spears','Brynne');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Wells','Finn'),
    ('Brown','Cameron'),
    ('Wood','Alec'),
    ('Herman','Caldwell'),
    ('Knox','Thaddeus'),
    ('Whitehead','Tiger'),
    ('Koch','Samson'),
    ('Key','Barrett'),
    ('Petty','Frances'),
    ('Ratliff','Lilah');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Franco','Guy'),
    ('Barnes','Rama'),
    ('Cummings','Yuli'),
    ('Pacheco','Lee'),
    ('Cotton','Stacey'),
    ('Hanson','Daria'),
    ('Burch','Giselle'),
    ('Steele','Beverly'),
    ('Gilmore','Kelsie'),
    ('Crane','Ori');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Spencer','Roary'),
    ('Richardson','Ulysses'),
    ('Ramsey','Serina'),
    ('Gomez','Eaton'),
    ('Potts','Steel'),
    ('Bradshaw','Jin'),
    ('Stewart','Chaney'),
    ('Macias','Chaney'),
    ('Brewer','Nigel'),
    ('Reeves','Risa');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Carrillo','Perry'),
    ('Riddle','Flynn'),
    ('Casey','Valentine'),
    ('Middleton','Erich'),
    ('Acosta','Branden'),
    ('Maldonado','Ray'),
    ('Chen','Bell'),
    ('Lopez','Bernard'),
    ('Joyce','Elliott'),
    ('Benjamin','Vaughan');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Eaton','Mason'),
    ('Cooper','Nell'),
    ('Mcneil','Carolyn'),
    ('Cameron','Jonas'),
    ('William','Aladdin'),
    ('Page','Chloe'),
    ('Fox','Celeste'),
    ('Schultz','Hedwig'),
    ('Bailey','TaShya'),
    ('Holland','Lev');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Sharpe','Dillon'),
    ('Daniels','Sacha'),
    ('Padilla','Ruth'),
    ('Glass','Stone'),
    ('Trevino','Gray'),
    ('Garrett','Kiara'),
    ('Bradshaw','Summer'),
    ('Hebert','Kareem'),
    ('Deleon','Amber'),
    ('Mcconnell','Kelsie');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Mejia','Dustin'),
    ('Blake','Ulla'),
    ('Kline','Matthew'),
    ('Mcpherson','Benjamin'),
    ('Mack','Beverly'),
    ('Lester','Judah'),
    ('Bender','Mark'),
    ('Watson','Hollee'),
    ('Head','Reed'),
    ('Mullins','Ciaran');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Trevino','Heidi'),
    ('Kent','Lars'),
    ('Grant','Darius'),
    ('Obrien','Raja'),
    ('Farley','Rina'),
    ('Anthony','Shellie'),
    ('Hendricks','Jack'),
    ('Pratt','Malik'),
    ('Cannon','Bernard'),
    ('Walls','Christian');

INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Frederick','Hyacinth'),
    ('Arnold','Lewis'),
    ('Chandler','Yardley'),
    ('Duncan','Lev'),
    ('Reed','Hashim'),
    ('Tate','Rhoda'),
    ('Robinson','Yuri'),
    ('Lang','Aurelia'),
    ('Gutierrez','Tasha'),
    ('Padilla','Cathleen');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Callahan','Coby'),
    ('Sellers','Alan'),
    ('Copeland','Heidi'),
    ('Orr','Colby'),
    ('Jones','Burton'),
    ('Marsh','Nerea'),
    ('Gilliam','Damian'),
    ('Spears','Genevieve'),
    ('Finch','Florence'),
    ('Boone','Amena');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Foster','Declan'),
    ('Durham','Shana'),
    ('Beck','Mira'),
    ('Haney','Andrew'),
    ('Hahn','Martha'),
    ('Callahan','Castor'),
    ('Pennington','Sacha'),
    ('Ballard','Clare'),
    ('Gonzalez','Amela'),
    ('Gallegos','Carissa');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Allen','Geoffrey'),
    ('Sweet','Olympia'),
    ('Emerson','Kaseem'),
    ('Koch','Shannon'),
    ('Cote','Luke'),
    ('Bullock','Martina'),
    ('Holt','Deanna'),
    ('Rowland','Jermaine'),
    ('Kirk','Charissa'),
    ('Pope','Baxter');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Terrell','Sophia'),
    ('Colon','Dorothy'),
    ('Macias','Moses'),
    ('Dalton','Mona'),
    ('Raymond','Elmo'),
    ('Sanders','Luke'),
    ('Bowen','Joseph'),
    ('Mckee','Uriel'),
    ('Morton','Emerald'),
    ('Golden','Jemima');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Stark','Ciara'),
    ('Barrera','Rinah'),
    ('Wilkerson','Nero'),
    ('Cox','Colin'),
    ('Campos','Keelie'),
    ('Small','Bruno'),
    ('Rocha','Jane'),
    ('Sanford','Basia'),
    ('Todd','Eliana'),
    ('Mcfarland','Elton');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Lynch','Rahim'),
    ('Flowers','Eric'),
    ('Bennett','Wayne'),
    ('Molina','Hadley'),
    ('Bean','Mason'),
    ('Koch','Jessica'),
    ('Norton','Amena'),
    ('Bernard','Solomon'),
    ('Livingston','Callum'),
    ('Wilson','Regina');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Nash','Tiger'),
    ('Donaldson','Malik'),
    ('Perry','Merritt'),
    ('Bass','Illana'),
    ('Foley','Garrett'),
    ('Brown','Palmer'),
    ('Collins','Brynne'),
    ('Acevedo','Camilla'),
    ('Mccullough','Martina'),
    ('Caldwell','Hamish');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Phelps','Thomas'),
    ('Craig','Buffy'),
    ('Landry','William'),
    ('Russo','Xavier'),
    ('Meadows','Yasir'),
    ('Goodman','Cameron'),
    ('Booker','Grady'),
    ('Dean','Lars'),
    ('Cantu','Kelsey'),
    ('Garner','Margaret');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Shepherd','Hermione'),
    ('Talley','Azalia'),
    ('Christensen','Hilel'),
    ('Dale','Brenden'),
    ('Hanson','Paki'),
    ('Holcomb','Noble'),
    ('Phelps','Jael'),
    ('Sanders','Lionel'),
    ('Weeks','Lars'),
    ('Holden','Ainsley');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Kramer','Serina'),
    ('Glover','Lucian'),
    ('Conley','Elton'),
    ('Chapman','Ava'),
    ('Green','Timon'),
    ('Rodriquez','Jaden'),
    ('Marshall','Caldwell'),
    ('Blackburn','Portia'),
    ('Rodgers','Shaeleigh'),
    ('Sloan','Hilda');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Koch','Tanya'),
    ('Miles','Aristotle'),
    ('Eaton','Amir'),
    ('Weiss','Quentin'),
    ('Hayes','Noelani'),
    ('Lindsay','Dieter'),
    ('Gonzalez','Desiree'),
    ('Travis','Brynne'),
    ('Bass','Chastity'),
    ('Fowler','Octavia');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Holland','Minerva'),
    ('Collins','Serena'),
    ('Wheeler','Signe'),
    ('Avila','Chastity'),
    ('Fuentes','Robin'),
    ('Mckenzie','Lysandra'),
    ('Day','Randall'),
    ('Knox','Cody'),
    ('Cannon','Camille'),
    ('Palmer','Carissa');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Harmon','Erich'),
    ('Patel','Jamal'),
    ('Clarke','Zoe'),
    ('Little','Nevada'),
    ('Pratt','Emily'),
    ('Waters','Sandra'),
    ('Mayer','Ivana'),
    ('Johnston','Cassady'),
    ('Foster','Clayton'),
    ('Dyer','Elijah');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Brooks','Ronan'),
    ('Garza','Amal'),
    ('Best','Caldwell'),
    ('Crosby','Susan'),
    ('Everett','Carly'),
    ('Moses','Sierra'),
    ('Dotson','Lesley'),
    ('Ellison','Aimee'),
    ('Kelly','Maya'),
    ('Justice','Madeson');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Nguyen','Irma'),
    ('Hart','Ulysses'),
    ('Santana','Colton'),
    ('Pennington','Charde'),
    ('Mcleod','Colton'),
    ('Cotton','Wing'),
    ('Gallagher','Shelly'),
    ('Becker','Yvette'),
    ('Mcgee','Kennedy'),
    ('Kirk','Tyler');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Rich','Jayme'),
    ('Beard','Tanek'),
    ('Hayes','Jerry'),
    ('Stuart','Paul'),
    ('Lucas','Macon'),
    ('Hurst','Levi'),
    ('Justice','Macey'),
    ('Leonard','Regina'),
    ('Stevenson','Denton'),
    ('Kelley','Nell');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Flynn','Ariel'),
    ('Witt','Shelly'),
    ('Donovan','Ignacia'),
    ('Ratliff','Haviva'),
    ('Henderson','Sigourney'),
    ('Anderson','Noah'),
    ('Haney','Barrett'),
    ('Pacheco','Ima'),
    ('Collins','Vladimir'),
    ('Johns','Desirae');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Hood','Beck'),
    ('Wynn','Derek'),
    ('Leon','Derek'),
    ('Jackson','Camden'),
    ('Avila','Barclay'),
    ('Chen','Yolanda'),
    ('Solis','Kasimir'),
    ('Hays','Barbara'),
    ('Oneil','Jackson'),
    ('Velez','Sebastian');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Booker','Wendy'),
    ('Roberts','Mercedes'),
    ('Conley','Kato'),
    ('Simon','Evan'),
    ('Mejia','Byron'),
    ('Blake','Giacomo'),
    ('Jarvis','Allistair'),
    ('Beach','Quyn'),
    ('Beasley','Sonya'),
    ('Soto','Jameson');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Mcleod','Shelly'),
    ('Sampson','Seth'),
    ('Acosta','Zahir'),
    ('Sparks','Stephen'),
    ('Hooper','Stephanie'),
    ('Mcknight','Maia'),
    ('Justice','Dawn'),
    ('Rodriguez','Cameron'),
    ('Black','Kiona'),
    ('Boone','Lester');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Morrison','Olivia'),
    ('Mccarthy','Nathaniel'),
    ('Wolfe','Yolanda'),
    ('Townsend','Quin'),
    ('Cohen','Iona'),
    ('Carrillo','Sylvester'),
    ('Glover','Laura'),
    ('Carroll','Wallace'),
    ('Willis','Jordan'),
    ('Gibbs','Rashad');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Lester','Blythe'),
    ('Fox','Cadman'),
    ('Mcbride','Kyle'),
    ('Montgomery','Rae'),
    ('Molina','Felix'),
    ('Bates','Amelia'),
    ('Rios','Kane'),
    ('Cochran','Vance'),
    ('Huffman','Maryam'),
    ('Warren','Peter');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Short','Ebony'),
    ('Blackburn','Jaime'),
    ('Kaufman','Hollee'),
    ('Hutchinson','Mark'),
    ('House','Joseph'),
    ('Huber','Danielle'),
    ('Randall','Branden'),
    ('Mack','Jane'),
    ('Oconnor','Mari'),
    ('Ratliff','Kiona');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Hardy','Victor'),
    ('Potter','Josiah'),
    ('Walter','Tanya'),
    ('Joseph','Meredith'),
    ('Evans','Beverly'),
    ('Coffey','Naomi'),
    ('Townsend','Edward'),
    ('Mullins','Claudia'),
    ('Riggs','Angela'),
    ('Sherman','Haviva');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Cash','Donna'),
    ('Solis','Troy'),
    ('Wilkerson','Marsden'),
    ('Leon','Dolan'),
    ('Alvarado','Jana'),
    ('Waters','Deirdre'),
    ('Harrison','Nicholas'),
    ('Kim','Samantha'),
    ('Reese','Basia'),
    ('Lopez','Dalton');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Clay','Gisela'),
    ('Guy','Clare'),
    ('Mcdonald','Britanni'),
    ('Holland','Colt'),
    ('Callahan','Signe'),
    ('Barr','Dorothy'),
    ('Rhodes','Henry'),
    ('Sheppard','Doris'),
    ('Moreno','Deanna'),
    ('Downs','Neville');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Holcomb','Palmer'),
    ('Houston','Pearl'),
    ('Willis','Avram'),
    ('Arnold','Patrick'),
    ('Rodgers','Ivan'),
    ('Mclean','Yen'),
    ('Davenport','Shelley'),
    ('Carson','Norman'),
    ('Watts','Reece'),
    ('Hunt','Bevis');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Dean','Pandora'),
    ('Vang','Craig'),
    ('Moody','Clinton'),
    ('Velez','Griffin'),
    ('Carrillo','Boris'),
    ('Benjamin','Denton'),
    ('Reynolds','Heather'),
    ('Hardy','Xaviera'),
    ('Francis','Dara'),
    ('Griffith','Brandon');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Cruz','Marshall'),
    ('Rivera','Deborah'),
    ('Duncan','Duncan'),
    ('Olson','Fredericka'),
    ('Santos','Timothy'),
    ('Jackson','Carissa'),
    ('Schmidt','Sage'),
    ('Alexander','Kyla'),
    ('Calderon','Wendy'),
    ('Sullivan','Carlos');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Parks','Freya'),
    ('Drake','Emmanuel'),
    ('Woodard','Mohammad'),
    ('Dickson','Mia'),
    ('Puckett','Allen'),
    ('Mcpherson','Athena'),
    ('Miller','Oren'),
    ('Mccarthy','Salvador'),
    ('Glass','Ferris'),
    ('Benton','Jermaine');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Velez','Rebecca'),
    ('Cline','Eugenia'),
    ('Sandoval','Hilary'),
    ('Compton','Rudyard'),
    ('Puckett','Hayden'),
    ('Blanchard','Xena'),
    ('Anthony','Wade'),
    ('Peck','Yvonne'),
    ('Gonzalez','Raven'),
    ('Hayes','Joshua');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Reeves','Judah'),
    ('Hickman','Norman'),
    ('Frank','Francis'),
    ('Glass','Madison'),
    ('Skinner','Boris'),
    ('Pennington','Wade'),
    ('Mcfarland','Frances'),
    ('Love','Merrill'),
    ('Franks','Jason'),
    ('Quinn','Omar');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Riddle','Cassady'),
    ('Joyce','Ivory'),
    ('Steele','Brennan'),
    ('Mckinney','Austin'),
    ('Andrews','Fletcher'),
    ('Elliott','Lana'),
    ('Beck','Nero'),
    ('Guzman','Aimee'),
    ('Crosby','Emerald'),
    ('Butler','Elmo');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Stanley','Vera'),
    ('Rollins','Amethyst'),
    ('Bass','Rachel'),
    ('Flynn','Ina'),
    ('Holman','Ebony'),
    ('Schneider','Giacomo'),
    ('Little','Carol'),
    ('Mcleod','Brett'),
    ('Ashley','Maile'),
    ('Sandoval','Michael');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Buck','Ulysses'),
    ('Holcomb','Thomas'),
    ('House','Cade'),
    ('Barlow','Rashad'),
    ('Parrish','Jarrod'),
    ('Gaines','Lunea'),
    ('Atkins','Teegan'),
    ('Mcpherson','Harding'),
    ('Marshall','Maxine'),
    ('Dixon','Fitzgerald');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Todd','Arthur'),
    ('Vincent','Harriet'),
    ('Herman','Hop'),
    ('Whitehead','Denise'),
    ('Mercer','Cooper'),
    ('Haynes','Erin'),
    ('Rocha','Fitzgerald'),
    ('Hester','Yuli'),
    ('Hogan','Cheyenne'),
    ('Howard','Flynn');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Hood','Rahim'),
    ('Crawford','Florence'),
    ('Strong','Violet'),
    ('Glover','Kiayada'),
    ('Hardin','Daniel'),
    ('Donovan','Nehru'),
    ('Hicks','Dominique'),
    ('Silva','Nathaniel'),
    ('Kirkland','Richard'),
    ('Campbell','Inez');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Martin','Barrett'),
    ('Rose','Yoshi'),
    ('Rutledge','Margaret'),
    ('Armstrong','Adam'),
    ('Guerrero','Tiger'),
    ('Frazier','Kadeem'),
    ('Acosta','Lael'),
    ('Boyd','Tyrone'),
    ('Berger','Jakeem'),
    ('Ramsey','Mohammad');
INSERT INTO fisioterapeuta (apellidos,nombre)
VALUES
    ('Matthews','Wanda'),
    ('Tillman','Blake'),
    ('Hernandez','Zelenia'),
    ('Buckley','Gay'),
    ('Silva','Scarlett'),
    ('Townsend','Zenia'),
    ('Clayton','Tobias'),
    ('Mann','India'),
    ('Landry','Kylie');

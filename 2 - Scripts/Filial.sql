---Tabela de Filial
create table filial (
id_filial serial primary key,
regiao VARCHAR
);

---Insert
insert into filial(regiao) values
('Central'),
('Interior'),
('Baixada');
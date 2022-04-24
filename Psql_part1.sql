/*recriacao do projeto do livro sistema de banco de dados
* de Ramez Elmasri com o intuito de pratica de SQL
*/
-- password=12345;
CREATE ROLE yuri SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN PASSWORD '12345';
create database uvv with
	owner = yuri 
	template = template0
	encoding = UTF8
  lc_collate = 'pt_BR.UTF-8'
	lc_ctype = 'pt_BR.UTF-8'
;
\c uvv yuri;
-- dividido em partes para evitar problemas com requirimento de senha atrapalhar a execucao do codigo;
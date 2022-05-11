--questão 1 media salarial de cada departamento;
select AVG(salario) as mediaSalarialDepartamento1e4e5 from funcionario where numero_departamento=1
union
select AVG(salario) from funcionario where numero_departamento=4
union
select AVG(salario) from funcionario where numero_departamento=5;

--questão 2 media salarial por genero (masculino, feminino);
select AVG(salario) as mediaSalarialMasculinaEFeminina from funcionario where sexo='M'
union
select AVG(salario) from funcionario where sexo='F';

/*QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para cada departamento,
 *  inclua as seguintes informações de seus funcionários: 
 * o nome completo, a data de nascimento, a idade em anos completos e o salário.
 */
select departamento.nome_departamento,concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,funcionario.data_nascimento,year(current_date())- year(data_nascimento) as idade ,funcionario.salario,funcionario.numero_departamento 
as infosDepartamento1e4e5 from departamento,funcionario 
where departamento.numero_departamento=1 and funcionario.numero_departamento=1
union
select departamento.nome_departamento,concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,funcionario.data_nascimento,year(current_date())- year(data_nascimento) as idade ,funcionario.salario,funcionario.numero_departamento 
as infosDepartamento4 from departamento,funcionario 
where departamento.numero_departamento=4 and funcionario.numero_departamento=4
union
select departamento.nome_departamento,concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,funcionario.data_nascimento,year(current_date())- year(data_nascimento) as idade ,funcionario.salario,funcionario.numero_departamento 
as infosDepartamento5 from departamento,funcionario 
where departamento.numero_departamento=5 and funcionario.numero_departamento=5;

/*QUESTÃO 04: prepare um relatório que mostre o nome completo dos funcionários,
*a idade em anos completos, o salário atual e o salário com um reajuste que
*obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o
*reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a
*35.000 o reajuste deve ser de 15%.
*/
select concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo , salario as salario_atual,
if(salario < 35000, salario /100 *120, salario /100 *120) as salario_reajustado 
from funcionario;

/*QUESTÃO 05: prepare um relatório que liste, para cada departamento, o nome
*do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento
*(em ordem crescente) e por salário dos funcionários (em ordem decrescente).
*/
select departamento.nome_departamento ,if(departamento.cpf_gerente = funcionario.cpf, 'gerente' , 'funcionario') as função , concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo 
from departamento,funcionario where funcionario.numero_departamento = departamento.numero_departamento
order by departamento.nome_departamento  asc, funcionario.salario desc;

/*QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários
*que têm dependentes, o departamento onde eles trabalham e, para cada funcionário,
*também liste o nome completo dos dependentes, a idade em anos de cada
*dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer
*como “Masculino” ou “Feminino”).
*/
-- para o nome completo considerei a tradição de nome de familia e repeti os sobrenome e adicionei o nome pois não ha dados do restante do nome vai ser usado em mais uma futura query;
select concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo , funcionario.numero_departamento , 
concat(dependente.nome_dependente ," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo_dependente ,
year(current_date())- year(dependente.data_nascimento) as idade_dependente,
if(dependente.sexo = 'M', 'Masculino' , 'Feminino') as sexo 
from funcionario,dependente where funcionario.cpf = dependente.cpf_funcionario;

/*QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO
*TEM dependente, seu nome completo, departamento e salário.
*/
select distinct concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
funcionario.numero_departamento , funcionario.salario 
from funcionario
inner join departamento on funcionario.numero_departamento=departamento.numero_departamento
left  join dependente on funcionario.cpf=dependente.cpf_funcionario 
where dependente.nome_dependente is null;

/*QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos
*desse departamento e o nome completo dos funcionários que estão alocados
*em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário,
*em cada projeto.
*/
select distinct departamento.nome_departamento,departamento.numero_departamento,projeto.nome_projeto ,
concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
trabalha_em.horas
from departamento ,funcionario ,trabalha_em ,projeto 
where departamento.numero_departamento = funcionario.numero_departamento and departamento.numero_departamento = projeto.numero_departamento
and projeto.numero_projeto = trabalha_em.numero_projeto ; 

/*QUESTÃO 09: prepare um relatório que mostre a soma total das horas de cada
 *projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento,
 *o nome do projeto e a soma total das horas.
 */
select departamento.nome_departamento, projeto.nome_projeto, SUM(trabalha_em.horas) as horas
from trabalha_em
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto
inner join departamento on departamento.numero_departamento = projeto.numero_departamento
group by projeto.nome_projeto
order by departamento.nome_departamento asc;

/*QUESTÃO 10: prepare um relatório que mostre a média salarial dos funcionários
*de cada departamento.
*/
select departamento.nome_departamento,avg(funcionario.salario) 
as Media_Salarial_do_Departamento from departamento,funcionario 
where departamento.numero_departamento = funcionario.numero_departamento 
group by funcionario.numero_departamento;

/*QUESTÃO 11: considerando que o valor pago por hora trabalhada em um projeto
*é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o
*nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas
*naquele projeto.
 */
select concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
projeto.nome_projeto , trabalha_em.horas *50 as valor_pagamento 
from funcionario 
inner join projeto on funcionario.numero_departamento = projeto.numero_departamento
inner join trabalha_em on trabalha_em.numero_projeto = projeto.numero_projeto; 

/*QUESTÃO 12: seu chefe está verificando as horas trabalhadas pelos funcionários
*nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum
*projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório
*que liste o nome do departamento, o nome do projeto e o nome dos funcionários
*que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.
*/
select concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
projeto.nome_projeto , departamento.nome_departamento 
from departamento ,funcionario  
inner join projeto on funcionario.numero_departamento = projeto.numero_departamento
inner join trabalha_em on trabalha_em.numero_projeto = projeto.numero_projeto
where horas = 0 
group by cpf;

/*QUESTÃO 13: durante o natal deste ano a empresa irá presentear todos os funcionários
*e todos os dependentes (sim, a empresa vai dar um presente para cada
*funcionário e um presente para cada dependente de cada funcionário) e pediu para
*que você preparasse um relatório que listasse o nome completo das pessoas a serem
*presenteadas (funcionários e dependentes), o sexo e a idade em anos completos
*(para poder comprar um presente adequado). Esse relatório deve estar ordenado
*pela idade em anos completos, de forma decrescente.
*/
select distinct concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
if(funcionario.sexo = 'M', 'Masculino' , 'Feminino') as sexo_funcionario,
year(current_date())- year(funcionario.data_nascimento) as idade_funcionario,
concat(dependente.nome_dependente ," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo_dependente ,
if(dependente.sexo = 'M', 'Masculino' , 'Feminino') as sexo_dependente,
year(current_date())- year(dependente.data_nascimento) as idade_dependente
from departamento , funcionario 
left outer join dependente on funcionario.cpf = dependente.cpf_funcionario 
order by idade_funcionario desc , idade_dependente desc;


/*QUESTÃO 14: prepare um relatório que exiba quantos funcionários cada departamento tem.
*/
select departamento.nome_departamento , count(funcionario.cpf) as n_funcionarios_dep
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by funcionario.numero_departamento; 

/*QUESTÃO 15: como um funcionário pode estar alocado em mais de um projeto,
*prepare um relatório que exiba o nome completo do funcionário, o departamento
*desse funcionário e o nome dos projetos em que cada funcionário está alocado.
*Atenção: se houver algum funcionário que não está alocado em nenhum projeto,
*o nome completo e o departamento também devem aparecer no relatório.
 */
select concat(funcionario.primeiro_nome," ",funcionario.nome_meio,"."," ",funcionario.ultimo_nome) as nome_completo ,
funcionario.numero_departamento, projeto.nome_projeto
from funcionario
left join trabalha_em on trabalha_em.cpf_funcionario = funcionario.cpf
left join projeto on projeto.numero_projeto=trabalha_em.numero_projeto
order by nome_completo asc;
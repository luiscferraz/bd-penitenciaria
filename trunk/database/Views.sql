-- capacidade excedida com WHERE
select id_cela, capacidade, count(id_preso) as total
from cela_has_preso, cela
where id_cela = id
group by id_cela
having count(id_preso) > capacidade;

-- capacidade excedida com LEFT JOIN
select id_cela, capacidade, count(id_preso) as total 
from cela_has_preso 
left join cela on id = id_cela
group by id_cela
having count(id_preso) > capacidade


-- Tempo restante da pena;
select p.cpf, p.nome, sum(c.pena) as dias_pena_total, pe.data_entrada, 
ADDDATE(pe.data_entrada,INTERVAL sum(c.pena) DAY) AS data_final,
DATEDIFF(ADDDATE(pe.data_entrada,INTERVAL sum(c.pena) DAY), CURDATE() ) AS dias_restantes
from preso as p, prontuario_has_crime as pc, prontuario as pr, crime as c, pena as pe where
p.id = pr.id_preso and
pc.id_prontuario = pr.id_preso and
pe.id_preso = p.id and
pc.id_crime = c.id
group by p.id


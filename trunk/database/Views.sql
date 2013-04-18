-- sql capacidade excedida

select cp.id_cela, c.capacidade, count(id_preso) as total
from cela as c, cela_has_preso as cp
where
cp.id_cela = c.id 
group by
cp.id_cela 
having total > (select capacidade from cela where cp.id_cela = cela.id)

-- Tempo restante da pena;
select p.cpf, p.nome, sum(c.pena) as penatotal, pe.data_entrada, 
ADDDATE(pe.data_entrada,INTERVAL sum(c.pena) DAY) AS datafinal,
DATEDIFF(ADDDATE(pe.data_entrada,INTERVAL sum(c.pena) DAY), CURDATE() ) AS Dias_Restantes
from preso as p, prontuario_has_crime as pc, prontuario as pr, crime as c, pena as pe where
p.id = pr.id_preso and
pc.id_prontuario = pr.id_preso and
pe.id_preso = p.id and
pc.id_crime = c.id
group by p.id


-- 1️. Listar todos os alunos e os nomes das turmas
-- em que estão matriculados

SELECT a.nome AS "Aluno", t.nome AS "Turma"
FROM aluno a
JOIN turma t ON a.turma_id = t.id_turma;

-- ️2. Contar quantos alunos estão matriculados em cada turma
-- ( Usa GROUP BY e COUNT() para contar os alunos por turma.)

SELECT t.nome AS "Turma", COUNT(a.nome) AS "Qtd_Alunos"
FROM aluno a
JOIN turma t ON a.turma_id = t.id_turma
GROUP BY t.nome;

-- ️3. Mostrar a média de idade dos alunos em cada turma
-- Usa AVG() e DATEDIFF() para calcular a idade média dos alunos.

SELECT t.nome AS "Turma", 
       ROUND(AVG(EXTRACT(YEAR FROM AGE(a.data_nascimento)))) AS "Média de Idade"
FROM aluno a
JOIN turma t ON a.turma_id = t.id_turma
GROUP BY t.nome


-- ️4. Encontrar as turmas com mais de 3️ alunos matriculados
-- (Usa HAVING para filtrar apenas as turmas com mais de 3 alunos.)

SELECT t.nome AS "Turma"
FROM aluno a
JOIN turma t ON a.turma_id = t.id_turma
GROUP BY t.nome
HAVING COUNT(a.cod_matricula) > 3;

-- 5️. Exibir os instrutores que orientam turmas
-- e os que ainda não possuem turmas

SELECT i.nome AS "Nome do Instrutor", COALESCE(t.nome, 'Sem Turma') AS "Nome da turma"
FROM instrutor i 
LEFT JOIN turma t ON i.id_instrutor = t.instrutor_id;

-- 6️. Encontrar alunos que frequentaram todas as aulas de sua turma
-- ( Usa COUNT() 
-- para comparar a quantidade de presenças com a quantidade de aulas.)

SELECT a.nome, c.presente
FROM aluno a
JOIN chamada c ON a.cod_matricula = c.matricula_cod

-- 7️. Mostrar os instrutores que ministram turmas de "Crossfit" ou "Yoga"


SELECT i.nome AS "Nome do Instrutor", t.nome AS "Nome da Turma"
FROM instrutor i
JOIN turma t ON i.id_instrutor = t.instrutor_id
WHERE t.nome LIKE '%Crossfit%' OR t.nome LIKE '%Yoga%';

-- 8️. Listar os alunos que  estão matriculados em mais de uma turma

SELECT a.nome AS "Nome do Aluno"
FROM aluno a
GROUP BY a.nome
HAVING COUNT(a.turma_id) > 1;

-- 9. Encontrar as turmas que possuem a maior quantidade de alunos

SELECT t.nome AS "Nome da Turma", COUNT(a.cod_matricula) AS "Quantidade de Alunos"
FROM turma t
JOIN aluno a ON t.id_turma = a.turma_id
GROUP BY t.nome
ORDER BY COUNT(a.cod_matricula) DESC
LIMIT 1;

-- 10. Listar os alunos que não compareceram a nenhuma aula
-- (Usa NOT IN para encontrar alunos sem registros na tabela chamada.

SELECT a.nome AS "Nome do Aluno"
FROM aluno a
WHERE a.cod_matricula NOT IN (
    SELECT matricula_cod


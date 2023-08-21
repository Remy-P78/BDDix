--1. Liste des potions : NumÃ©ro, libellÃ©, formule et constituant principal. (5 lignes)

select * from potion;


--2. Liste des noms des trophÃ©es rapportant 3 points. (2 lignes)

select nom_categ from categorie where nb_points = 3;


--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

select nom_village from village where nb_huttes > 35;


--4. Liste des trophÃ©es (numÃ©ros) pris en mai / juin 52. (4 lignes)

select num_trophee from trophee where date_prise >= '2052-05-01' and date_prise < '2052-07-01';



--5. Noms des habitants commenÃ§ant par 'a' et contenant la lettre 'r'. (3 lignes)

select nom from habitant where nom like 'A%r%';


--6. NumÃ©ros des habitants ayant bu les potions numÃ©ros 1, 3 ou 4. (8 lignes)

select distinct num_hab  from absorber where num_potion in (1,3,4) ;



--7. Liste des trophÃ©es : numÃ©ro, date de prise, nom de la catÃ©gorie et nom du preneur. (10lignes)

select trophee.num_trophee, trophee.date_prise, categorie.nom_categ , habitant.nom  
from trophee 
inner join categorie on 
trophee.code_cat = categorie.code_cat 
inner join habitant on
trophee.num_preneur = habitant.num_hab;


--8. Nom des habitants qui habitent Ã  Aquilona. (7 lignes)

select nom 
from habitant 
inner join village on habitant.num_village = village.num_village 
where village.nom_village like 'Aquilona';




--9. Nom des habitants ayant pris des trophÃ©es de catÃ©gorie Bouclier de LÃ©gat. (2 lignes)

select nom
from habitant 
inner join trophee on habitant.num_hab = trophee.num_preneur
inner join categorie on trophee.code_cat = categorie.code_cat
where categorie.nom_categ = 'Bouclier de Légat';




--10. Liste des potions (libellÃ©s) fabriquÃ©es par Panoramix : libellÃ©, formule et constituantprincipal. (3 lignes)

select lib_potion, formule, constituant_principal
from potion p 
inner join fabriquer f  on p.num_potion  = f.num_potion 
inner join habitant h  on f.num_hab = h.num_hab 
where h.nom = 'Panoramix';




--11. Liste des potions (libellÃ©s) absorbÃ©es par HomÃ©opatix. (2 lignes)

select distinct lib_potion
from potion p 
inner join absorber a  on p.num_potion  = a.num_potion 
inner join habitant h  on a.num_hab = h.num_hab 
where h.nom = 'Homéopatix';




--12. Liste des habitants (noms) ayant absorbÃ© une potion fabriquÃ©e par l'habitant numÃ©ro 3. (4 lignes)

select distinct nom
from habitant h 
inner join absorber a on h.num_hab = a.num_hab
inner join potion p on a.num_potion = p.num_potion 
inner join fabriquer f on p.num_potion = f.num_potion 
where f.num_hab = 3 




--13. Liste des habitants (noms) ayant absorbÃ© une potion fabriquÃ©e par AmnÃ©six. (7 lignes)

select distinct h.nom
from habitant h 
inner join absorber a on h.num_hab = a.num_hab
inner join potion p on a.num_potion = p.num_potion 
inner join fabriquer f on p.num_potion = f.num_potion 
inner join habitant h2 on f.num_hab = h2.num_hab 
where h2.nom = 'Amnésix';



--14. Nom des habitants dont la qualitÃ© n'est pas renseignÃ©e. (2 lignes)

select distinct h.nom
from habitant h 
where num_qualite is NULL



--15. Nom des habitants ayant consommÃ© la Potion magique nÂ°1 (c'est le libellÃ© de lapotion) en fÃ©vrier 52. (3 lignes)

select distinct h.nom
from habitant h 
inner join absorber a on h.num_hab = a.num_hab 
inner join potion p on a.num_potion = p.num_potion 
where p.lib_potion = 'Potion magique n°1'
and a.date_a between '2052-02-01' and '2052-02-28';

Alternative :

and EXTRACT(MONTH FROM date_colonne) = 5 AND EXTRACT(YEAR FROM date_colonne) = 2052;




--16. Nom et Ã¢ge des habitants par ordre alphabÃ©tique. (22 lignes)

select nom, age
from habitant h 
order by nom;




--17. Liste des resserres classÃ©es de la plus grande Ã  la plus petite : nom de resserre et nom du village. (3 lignes)

select r.nom_resserre, v.nom_village 
from resserre r 
inner join village v on r.num_village = v.num_village 
order by r.nom_resserre ;


--18. Nombre d'habitants du village numÃ©ro 5. (4)

select count (*)
from habitant h 
where num_village = '5' ;


--19. Nombre de points gagnÃ©s par Goudurix. (5)

select c.nb_points
from categorie c 
join trophee t on c.code_cat = t.code_cat 
join  habitant h on t.num_preneur = h.num_hab 
where h.nom = 'Goudurix' ;



--20. Date de premiÃ¨re prise de trophÃ©e. (03/04/52)


select min (date_prise)
from trophee t ;



--21. Nombre de louches de Potion magique nÂ°2 (c'est le libellÃ© de la potion) absorbÃ©es. (19)

select sum (quantite)
from absorber a 
join potion p on a.num_potion = p.num_potion 
where p.lib_potion = 'Potion magique n°2' ;


--22. Superficie la plus grande. (895)

select max(superficie)
from resserre;



--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

select v.nom_village, count(h.num_hab)
from village v 
join habitant h on v.num_village = h.num_village  
group by v.nom_village;


--24. Nombre de trophÃ©es par habitant (6 lignes)

select h.nom, count(*)
from habitant h 
join trophee t  on h.num_hab  = t.num_preneur 
group by h.nom ;



--25. Moyenne d'Ã¢ge des habitants par province (nom de province, calcul). (3 lignes)

select p.nom_province, AVG(h.age) 
from province p 
join village v on p.num_province = v.num_province 
join habitant h on v.num_village = h.num_village 
group by p.nom_province ;




--26. Nombre de potions diffÃ©rentes absorbÃ©es par chaque habitant (nom et nombre). (9lignes)

select h.nom, count(*) as nbr_potions
from habitant h 
join absorber a on h.num_hab = a.num_hab 
group by h.nom;



--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

select h.nom
from habitant h 
join absorber a on h.num_hab = a.num_hab 
join potion p on a.num_potion = p.num_potion 
where p.lib_potion = 'Potion Zen'
group by h.nom
having sum(a.quantite) > 2;



--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

select v.nom_village
from village v 
join resserre r on v.num_village = r.num_village 
where  r.num_village is not null; 




--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

select v.nom_village
from village v 
order by v.nb_huttes desc 
limit 1;

Alternative

SELECT NOM_VILLAGE FROM VILLAGE V WHERE NB_HUTTES = (SELECT MAX(NB_HUTTES)FROM VILLAGE);




--30. Noms des habitants ayant pris plus de trophÃ©es qu'ObÃ©lix (3 lignes).

select h.nom
from habitant h 
join trophee t on h.num_hab = t.num_preneur 
group by h.nom 
having count(t.num_preneur)>(
select count(*)
from trophee t2
where t2.num_preneur = (
select num_hab
from habitant h2
where nom = 'Obélix')
);

Alternative

SELECT HABITANT.NOM 
FROM HABITANT 
JOIN TROPHEE ON HABITANT.NUM_HAB = TROPHEE.NUM_PRENEUR 
GROUP BY HABITANT.NOM 
HAVING COUNT(NUM_PRENEUR) > (
 SELECT COUNT(NUM_PRENEUR) 
FROM TROPHEE 
INNER JOIN HABITANT ON TROPHEE.NUM_PRENEUR = HABITANT.NUM_HAB 
WHERE HABITANT.NOM = 'Obélix');




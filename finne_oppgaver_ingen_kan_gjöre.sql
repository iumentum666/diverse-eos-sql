use IFSFSMPROD
SELECT
unike_oppgavernr.task_id, 
matche_alle_oppgaver_mot_alle_montører.person_id
FROM (
	SELECT q3_task_skill.task_id
	FROM (
			SELECT
			t.task_id,
			ts.skill

			from task t

			left join task_skill ts on ts.task_id = t.task_id
			--where t.task_status = 'Open' and ts.skill is not null
		) q3_task_skill
	GROUP BY q3_task_skill.task_id)
	unike_oppgavernr 

LEFT JOIN (
SELECT 
skills_pr_oppgave.task_id, 
skills_pr_oppgave.Antall_skills, 
telle_skills_pr_oppg_og_montør.person_id, 
telle_skills_pr_oppg_og_montør.Antall
FROM 
	(
	SELECT q2_task_skill.task_id, Count(q2_task_skill.skill) AS Antall_skills
	FROM (
			SELECT
			t.task_id,
			ts.skill

			from task t

			left join task_skill ts on ts.task_id = t.task_id
			--where t.task_status = 'Open' and ts.skill is not null
		) q2_task_skill
	GROUP BY q2_task_skill.task_id
	) skills_pr_oppgave

LEFT JOIN (
	SELECT 
	alle_oppgaver_med_skils_og_person.person_id, 
	alle_oppgaver_med_skils_og_person.task_id, Count(1) AS Antall
	FROM (
		SELECT 
		q_task_skill.task_id, 
		q_task_skill.skill, 
		person_skill.person_id,
		person_skill.active
		FROM (
			SELECT
			t.task_id,
			ts.skill

			from task t

			left join task_skill ts on ts.task_id = t.task_id
			--where t.task_status = 'Open' and ts.skill is not null
		) q_task_skill 
		LEFT JOIN person_skill ON q_task_skill.skill = person_skill.skill
		where person_skill.active = 'Y'
	) alle_oppgaver_med_skils_og_person

	GROUP BY alle_oppgaver_med_skils_og_person.person_id, alle_oppgaver_med_skils_og_person.task_id
	) telle_skills_pr_oppg_og_montør ON skills_pr_oppgave.task_id = telle_skills_pr_oppg_og_montør.task_id

WHERE (((telle_skills_pr_oppg_og_montør.Antall)=[Antall_skills]))
) matche_alle_oppgaver_mot_alle_montører ON unike_oppgavernr.task_id = matche_alle_oppgaver_mot_alle_montører.task_id
WHERE --matche_alle_oppgaver_mot_alle_montører.person_id is null and 
unike_oppgavernr.task_id = '387560'
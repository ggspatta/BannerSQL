--Midterm Grades
select  distinct nvl(zgen_email(sfrstcr_pidm,'*SHORT'),lower(spriden_id)) "user_integration_id",
        ssbsect_subj_code||ssbsect_crse_numb||'-'||ssbsect_seq_numb||'-'||lower(f_student_get_desc('STVTERM',ssbsect_term_code,30)) "course_section_integration_id",
        sfrstcr_grde_code_mid "midterm_grade",
        sfrstcr_grde_code "final_grade",
        sfrstcr_credit_hr "credit_hours",
        sfrstcr_gmod_code "enrollment_type",
        sfrstcr_activity_date "modified_ts"
from    stvrsts,
        sfrstcr,
        ssbsect,
        spriden
where
        spriden_pidm(+)         =sfrstcr_pidm
and     spriden_ntyp_code(+)    ='EMAL'
and     ssbsect_term_code       =sfrstcr_term_code
and     ssbsect_crn             =sfrstcr_crn
and     ssbsect_term_code       ='&v_term'
and     ssbsect_ssts_code       ='A' 
and     stvrsts_code            =sfrstcr_rsts_code 
and     sfrstcr_term_code       ='&v_term'
and     stvrsts_incl_sect_enrl  ='Y'
and     sfrstcr_levl_code       ='GR'       
order by 1,2;



--Final Grades

select  distinct nvl(zgen_email(szvahst_pidm,'*SHORT'),lower(spriden_id)),
        szvahst_subj_code||szvahst_crse_numb||'-'||szvahst_seq_numb||'-'||lower(f_student_get_desc('STVTERM',szvahst_term_code,30)),
        szvahst_grde_code_final,
        szvahst_credit_hours,
        CASE WHEN szvahst_gmod_code  ='A'   THEN 'AU'
             WHEN szvahst_gmod_code ='N'    THEN 'L'
             WHEN szvahst_gmod_code ='P'    THEN 'PF'
         END,    
        szvahst_final_grde_chg_date
from    szvahst,
        spriden
where   
        spriden_pidm(+) = szvahst_pidm
and     spriden_ntyp_code (+) ='EMAL' 
and     szvahst_term_code ='&v_term'
and     szvahst_subj_code = 'PHRM'

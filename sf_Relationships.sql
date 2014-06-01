--LOOP for start term 201001 to current term
--Primary Advisor Relationship

select  distinct nvl(zgen_email(sgradvr_advr_pidm,'*SHORT'),lower(s1.spriden_id)) "parent_integration_id", --advisor username
        'PRIMARY ADVISOR' "parent_role",
         nvl(zgen_email(sgradvr_pidm,'*SHORT'),lower(s2.spriden_id)) "child_id", --student username
        'STUDENT' "child_role",
        'ONGOING' "term_id"
from    
        sgradvr s3,
        spriden s2,
        spriden s1
where  
        s1.spriden_pidm (+) = sgradvr_advr_pidm ---advisor pidm
and     s1.spriden_ntyp_code (+) ='EMAL'        
and     s2. spriden_pidm = sgradvr_pidm  --student pidm
and     s2.spriden_ntyp_code (+) ='EMAL'     
and     sgradvr_term_code_eff = (select max(sgradvr_term_code_eff)
                                 from   sgradvr
                                 where  sgradvr_pidm = s3.sgradvr_pidm
                                 and    sgradvr_term_code_eff <= '&&term')
and     sgradvr_prim_ind ='Y'
and     zstu_levl(sgradvr_pidm,'&term') ='GR'
and     zstu_eff_headcount(sgradvr_pidm,'&term') ='Y'
order by 1,5;



--Primary Course Cooridnator
--LOOP for start term 201001 to current term

select  distinct nvl(zgen_email(sirasgn_pidm,'*SHORT'),lower(s1.spriden_id)), --instructor username
        'COURSE COORIDNATOR',
        nvl(zgen_email(sfrstcr_pidm,'*SHORT'),lower(s2.spriden_id)), --student username
        ssbsect_subj_code||ssbsect_crse_numb||'.'||ssbsect_crn,
        &&term
from    
        stvrsts,
        sfrstcr,
        sirasgn,
        ssbsect,
        spriden s2,
        spriden s1 
where    
        s1. spriden_pidm (+) = sirasgn_pidm --instructor pidm
and     s1.spriden_ntyp_code (+) ='EMAL'  
and     s2.spriden_pidm (+) = sfrstcr_pidm --student pidm
and     s2.spriden_ntyp_code (+) ='EMAL'  
and     ssbsect_term_code = sirasgn_term_code
and     ssbsect_crn = sirasgn_crn
and     ssbsect_term_code ='&&term' 
and     sirasgn_primary_ind ='Y'
and     ssbsect_term_code = sfrstcr_term_code
and     ssbsect_crn = sfrstcr_crn
and     sfrstcr_term_code ='&term'
and     stvrsts_code =sfrstcr_rsts_code
and     stvrsts_incl_sect_enrl = 'Y'
and     ssbsect_term_code ='&term'
and     ssbsect_ssts_code ='A'
and     zstu_levl(sfrstcr_pidm,'&term') ='GR'     
order by 1,5,3,4;    

select  ssbsect_subj_code||ssbsect_crse_numb||'.'||ssbsect_crn||'.'|| ssbsect_term_code, --||&cma||
        nvl(ssbsect_crse_title,scbcrse_title),
        ssbsect_subj_code||ssbsect_crse_numb||'.'||ssbsect_seq_numb||'.'|| ssbsect_term_code,
        to_char(ssbsect_ptrm_start_date,'YYYY-MM-DD'),
        to_char(ssbsect_ptrm_end_date,'YYYY-MM-DD'),
        ssbsect_term_code,
        ssbsect_crn,
        decode(ssbsect_insm_code,'NULL','01',
                                 'WEB','02'),
        to_char(ssbsect_activity_date,'YYYY-MM-DD HH24:MI:SS')
from    scbcrse s1,
        ssbsect
where   
        scbcrse_subj_code = ssbsect_subj_code
and     scbcrse_crse_numb = ssbsect_crse_numb
and     scbcrse_eff_term =(select max(scbcrse_eff_term)
                          from scbcrse
                          where scbcrse_subj_code =s1.scbcrse_subj_code
                          and scbcrse_crse_numb = s1.scbcrse_crse_numb)
                          
and     ssbsect_subj_code ='PHRM'
and     ssbsect_ssts_code ='A'
order by 1
/

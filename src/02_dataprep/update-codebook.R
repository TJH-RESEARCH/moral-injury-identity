


# Update Codebook -----------------------------------------------------

labelled::var_label(data$StartDate) <- 'Start Date'
labelled::var_label(data$EndDate) <- 'End Date'
labelled::var_label(data$Status) <- 'Response Type'
labelled::var_label(data$Progress) <- 'Progress in survey in percentage. Less than 100 indicates incomplete survey.'
labelled::var_label(data$`Duration (in seconds)`) <- 'Duration (in seconds)'
labelled::var_label(data$Finished) <- 'Finished'
labelled::var_label(data$RecordedDate) <- 'Recorded Date'
labelled::var_label(data$ResponseId) <- 'Response ID: Survey host meta data'
labelled::var_label(data$DistributionChannel) <- 'Distribution Channel'
labelled::var_label(data$UserLanguage) <- 'User Language'
labelled::var_label(data$Q_RecaptchaScore) <- 'Q_RecaptchaScore'
labelled::var_label(data$Q_RelevantIDDuplicate) <- 'Q_RelevantIDDuplicate'
labelled::var_label(data$Q_RelevantIDDuplicateScore) <- 'Q_RelevantIDDuplicateScore'
labelled::var_label(data$Q_RelevantIDFraudScore) <- 'Q_RelevantIDFraudScore'
labelled::var_label(data$Q_RelevantIDLastStartDate) <- 'Q_RelevantIDLastStartDate'

labelled::var_label(data$birth_year) <- 'What year were you born?'
labelled::var_label(data$at_least_18) <- 'Are you at least 18 years old?'
labelled::var_label(data$served) <- 'Did you serve in the United States military?'
labelled::var_label(data$separated) <- 'Are you now separated from the military? (e.g., discharged, released from active duty, transferred to the Inactive Ready Reserve)'

labelled::var_label(data$highest_rank) <- 'What is the highest pay grade you have achieved?'
labelled::var_label(data$rank_e1_e3) <- "Highest Paygrade Achieved: E-1 to E-3"
labelled::var_label(data$rank_e4_e6) <- "Highest Paygrade Achieved: E-4 to E-6"
labelled::var_label(data$rank_e7_e9) <- "Highest Paygrade Achieved: E-7 to E-9"
labelled::var_label(data$rank_w1_cw5) <- "Highest Paygrade Achieved: W-1 to CW-5"
labelled::var_label(data$rank_o1_o3) <- "Highest Paygrade Achieved: O-1 to O-3"
labelled::var_label(data$rank_o4_o6) <- "Highest Paygrade Achieved: O-4 to O-6"
labelled::var_label(data$highest_rank_numeric) <- "Highest Paygrade Achieved: Converted to numeric ranging from 1 (E-1 to E-3) to 6 (O-4 to O-6)"

labelled::var_label(data$officer) <- "Military Officer"
labelled::var_label(data$enlisted) <- "Enlisted Personnel"
labelled::var_label(data$warrant_officer) <- "Warrant Officer"

labelled::var_label(data$phone) <- 'Are you taking the survey on a phone?'
labelled::var_label(data$`Informed Consent`) <- 'Signed the informed consent'

labelled::var_label(data$active_duty) <- 'Did you ever serve on active duty?'
labelled::var_label(data$years_active) <- 'How many years were you on active duty?'
labelled::var_label(data$reserve) <- 'Are you still serving in any capacity (e.g., Reserve or Guard)?'

labelled::var_label(data$years_since_sep) <- 'How many years has it been since you left active duty?'
labelled::var_label(data$years_reserve_hidden) <- 'How many years did you serve in the military?'
labelled::var_label(data$years_service) <- 'How many years in total did/have you served in the military?'
labelled::var_label(data$years_separation) <- 'How many years since you were discharged from the military?'

labelled::var_label(data$discharge_reason) <- 'What was your reason for discharge?'
labelled::var_label(data$discharge_unexpected) <- "Reported either 'medical' or 'other' for discharge reasons. Calculated variable. Dichotomous."

labelled::var_label(data$branch) <- 'What branch(s) did you serve in? (Select all that apply)'
labelled::var_label(data$branch_air_force) <- 'What branch(s) did you serve in? - Air Force'
labelled::var_label(data$branch_army) <- 'What branch(s) did you serve in? - Army'
labelled::var_label(data$branch_coast_guard) <- 'What branch(s) did you serve in? - Coast Guard'
labelled::var_label(data$branch_marines) <- 'What branch(s) did you serve in? - Marines'
labelled::var_label(data$branch_navy) <- 'What branch(s) did you serve in? - Navy'
labelled::var_label(data$branch_space_force) <- 'What branch(s) did you serve in? - Space Force'
labelled::var_label(data$branch_public_health) <- 'What branch(s) did you serve in? - U.S. Public Health Service'
labelled::var_label(data$branch_none) <- 'What branch(s) did you serve in? - I have not served in the military'

labelled::var_label(data$military_exp_combat) <- 'During your military service, did you ever?: (select all that apply) - Serve in Combat'
labelled::var_label(data$military_exp_noncombat) <- 'During your military service, did you ever?: (select all that apply) - Deploy (non-combat)'
labelled::var_label(data$military_exp_support) <- 'During your military service, did you ever?: (select all that apply) - Engage in combat support'
labelled::var_label(data$military_exp_peacekeeping) <- 'During your military service, did you ever?: (select all that apply) - Deploy to a peacekeeping or humanitarian mission'
labelled::var_label(data$military_exp_none) <- "No combat, deployments, or combat support"
labelled::var_label(data$military_exp_total) <- "Number of different types of military experiences reported"

labelled::var_label(data$mos) <- 'What was your military occupation specialty?'
labelled::var_label(data$n_deploy) <- 'How many times did you deploy?'
labelled::var_label(data$disability) <- 'Do you receive Veterans Affairs (VA) disability?'
labelled::var_label(data$disability_percent) <- 'What is your VA disability percentage?'
labelled::var_label(data$validity_check_1) <- 'Which military pay grade is higher?'

labelled::var_label(data$unmet_needs_job) <- 'Unmet needs at discharge: not having a job (select all that apply)'
labelled::var_label(data$unmet_needs_housing) <- 'Unmet needs at discharge: not having a place to live (select all that apply)'
labelled::var_label(data$unmet_needs_healthcare) <- 'Unmet needs at discharge: no access to health care (select all that apply)'
labelled::var_label(data$unmet_needs_education) <- 'Unmet needs at discharge: no access to educational benefits (select all that apply)'
labelled::var_label(data$unmet_needs_records) <- 'Unmet needs at discharge: no access to medical or service records (select all that apply)'
labelled::var_label(data$unmet_needs_physical) <- 'Unmet needs at discharge: unmet physical health needs (select all that apply)'
labelled::var_label(data$unmet_needs_mental) <- 'Unmet needs at discharge: unmet mental health needs (select all that apply)'
labelled::var_label(data$unmet_needs_legal) <- 'Unmet needs at discharge: unresolved legal issues (select all that apply)'
labelled::var_label(data$unmet_needs_financial) <- 'Unmet needs at discharge: financial problems (select all that apply)'
labelled::var_label(data$unmet_needs_none) <- "Unmet needs at discharge: I didn't have any of these unmet needs  (select all that apply)"

labelled::var_label(data$military_family_spouse) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - Spouse/Partner'
labelled::var_label(data$military_family_parents) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - Parent'
labelled::var_label(data$military_family_sibling) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - Sibling (i.e., sister, brother)'
labelled::var_label(data$military_family_child) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - Child'
labelled::var_label(data$military_family_other) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - Other close family member'
labelled::var_label(data$military_family_none) <- 'Has anyone else in your immediate family served in the military? (select all that apply) - No one in my immediate family served in the military.'

labelled::var_label(data$honeypot1) <- 'To what extent do you enjoy retirement?'

labelled::var_label(data$mios_screener) <- 'Have you had an experience (or experiences) as described above?'
labelled::var_label(data$mios_event_type_self) <- 'The event involved: (select all that apply) - myself'
labelled::var_label(data$mios_event_type_other) <- 'The event involved: (select all that apply) - an other person'
labelled::var_label(data$mios_event_type_betrayal) <- 'The event involved: (select all that apply) - a betrayal'
labelled::var_label(data$mios_worst) <- 'For events that had multiple features, which aspect was the worst?'

labelled::var_label(data$mios_criterion_a) <- 'Did the event involve actual or threatened death, serious injury, or sexual violence?'
labelled::var_label(data$pc_ptsd_symptoms_nightmares) <- 'In the past month, have you… (select all that apply) - nightmares'
labelled::var_label(data$pc_ptsd_symptoms_avoid) <- 'In the past month, have you… (select all that apply) - avoid'
labelled::var_label(data$pc_ptsd_symptoms_vigilant) <- 'In the past month, have you… (select all that apply) - vigilant'
labelled::var_label(data$pc_ptsd_symptoms_numb) <- 'In the past month, have you… (select all that apply) - numb'
labelled::var_label(data$pc_ptsd_symptoms_guilty) <- 'In the past month, have you… (select all that apply) - guilty'
labelled::var_label(data$pc_ptsd_symptoms_none) <- 'In the past month, have you… (select all that apply) - none of the above'

labelled::var_label(data$mios_1) <- 'I blame myself.'
labelled::var_label(data$mios_2) <- 'I have lost faith in humanity.'
labelled::var_label(data$mios_3) <- 'People would hate me if they really knew me.'
labelled::var_label(data$mios_4) <- 'I have trouble seeing goodness in others.'
labelled::var_label(data$mios_5) <- 'People don’t deserve second chances.'
labelled::var_label(data$mios_6) <- 'I am disgusted by what happened.'
labelled::var_label(data$mios_7) <- 'I feel like I don’t deserve a good life.'
labelled::var_label(data$mios_8) <- 'I keep myself from having success.'
labelled::var_label(data$mios_9) <- 'There is no higher power.'
labelled::var_label(data$mios_10) <- 'I lost trust in others.'
labelled::var_label(data$mios_11) <- 'I am angry all the time.'
labelled::var_label(data$mios_12) <- 'I am not the good person I thought I was.'
labelled::var_label(data$mios_13) <- 'I have lost pride in myself.'
labelled::var_label(data$mios_14) <- 'I cannot be honest with other people.'

labelled::var_label(data$bipf_spouse) <- 'Romantic relationship with my spouse or partner.'
labelled::var_label(data$bipf_children) <- 'Relationship with my children'
labelled::var_label(data$bipf_family) <- 'Family relationships'
labelled::var_label(data$bipf_friends) <- 'Friendships or socializing'
labelled::var_label(data$bipf_work) <- 'Work'
labelled::var_label(data$bipf_education) <- 'Training or education'
labelled::var_label(data$bipf_daily) <- 'Day to day activities such as chores, errands, or managing medical care'

## BIIS-2

labelled::var_label(data$biis_1) <- 'I find it easy to harmonize Military and Civilian cultures.'
labelled::var_label(data$biis_2) <- 'I rarely feel conflicted about being both a citizen in the civilian world and a Service Member.'
labelled::var_label(data$biis_3) <- 'I find it easy to balance both my Military and Civilian cultures.'
labelled::var_label(data$biis_4) <- 'I do not feel trapped between Military culture and Civilian culture.'
labelled::var_label(data$biis_5) <- 'I feel torn between Military and Civilian cultures.'
labelled::var_label(data$biis_6) <- 'Being both a citizen in the civilian world and a Service Member means having two cultural forces pulling on me at the same time.'
labelled::var_label(data$biis_7) <- 'I feel that my Military and Civilian cultures are incompatible.'
labelled::var_label(data$biis_9) <- 'I feel like someone moving between two cultures.'
labelled::var_label(data$biis_8) <- 'I feel conflicted between the Military and Civilian ways of doing things.'
labelled::var_label(data$biis_10) <- 'I feel caught between the Military and Civilian cultures.'
labelled::var_label(data$biis_11) <- 'I cannot ignore the Military or Civilian side of me.'
labelled::var_label(data$biis_12) <- 'I feel like a Service Member and a Civilian at the same time.'
labelled::var_label(data$biis_13) <- 'I relate better to a combined culture than to Military or Civilian culture alone.'
labelled::var_label(data$biis_14) <- 'I feel like a Service Member-Civilian.'
labelled::var_label(data$biis_15) <- 'I feel part of a combined culture.'
labelled::var_label(data$biis_16) <- 'I do not blend my Military and Civilian cultures.'
labelled::var_label(data$biis_17) <- 'I keep Military and Civilian cultures separate.'
labelled::var_label(data$biis_total) <- "BIIS-2 Total Score (17 items)"
labelled::var_label(data$biis_harmony) <- "BIIS-2 Harmony Subscale Score (10 items). Higher scores indicate greater identity harmony and less identity conflict."
labelled::var_label(data$biis_blendedness) <- "BIIS-2 Blendedness Subscale Score (7 items)"
labelled::var_label(data$biis_conflict) <- "BIIS-2 Harmoney Subscale Score reversed (10 items). Higher scores indicate grat identity conflict and less identity harmony. "

labelled::var_label(data$attention_check_biis) <- 'Please answer this question with the response Somewhat Agree.'

labelled::var_label(data$difi_distance) <- 'The diagram below is designed to represent your relationship with a group ("American"). Please indicate your relationship by clicking and dragging the smaller "Me" circle to the position that best captures your relationship with this group. - Distance'
labelled::var_label(data$difi_overlap) <- 'The diagram below is designed to represent your relationship with a group ("American"). Please indicate your relationship by clicking and dragging the smaller "Me" circle to the position that best captures your relationship with this group. - Overlap'
labelled::var_label(data$difi_us) <- 'The diagram below is designed to represent your relationship with a group ("American"). Please indicate your relationship by selecting the choice where the smaller "Me" circle is in the position that best captures your relationship with this group.'

labelled::var_label(data$civilian_commit_1) <- 'I am clear about what being a civilian means to me.'
labelled::var_label(data$civilian_commit_2) <- 'I understand how I feel about being a civilian.'
labelled::var_label(data$civilian_commit_3) <- 'I know what being a civilian means to me.'
labelled::var_label(data$civilian_commit_4) <- 'I have a clear sense of what being a civilian means to me.'

labelled::var_label(data$wis_private_1) <- 'I am happy that I am a veteran.'
labelled::var_label(data$wis_private_2) <- 'I feel good about my military service.'
labelled::var_label(data$wis_private_3) <- 'I am proud of the things that veterans have accomplished.'
labelled::var_label(data$wis_private_4) <- 'I believe that I have many strengths due to my military service.'
labelled::var_label(data$wis_private_5) <- 'I often regret my military service.'
labelled::var_label(data$wis_private_6) <- 'I am proud to have served in the military.'
labelled::var_label(data$wis_private_7) <- 'I am ashamed of my military service.'

labelled::var_label(data$wis_interdependent_8) <- 'Only other veterans can truly understand me.'
labelled::var_label(data$wis_interdependent_9) <- 'When I meet other veterans I can trust them more quickly than other people.'
labelled::var_label(data$wis_interdependent_10) <- 'I become friends with other veterans more quickly than with non-veterans.'
labelled::var_label(data$wis_interdependent_11) <- 'My fate and future are bound up with that of veterans.'
labelled::var_label(data$wis_interdependent_12) <- 'Regarding other veterans, it is accurate to say, “United we stand, divided we fall.”'
labelled::var_label(data$wis_interdependent_13) <- 'The most important things that have happened in my life involve my military service.'
labelled::var_label(data$wis_interdependent_14) <- 'When I talk about the military, I usually say ‘we’ rather than ‘they.’'

labelled::var_label(data$wis_connection_15) <- 'During my time within my unit in the military I always felt like an outsider.'
labelled::var_label(data$wis_connection_16) <- 'I never felt emotionally connected to my military unit.'
labelled::var_label(data$wis_connection_17) <- 'Throughout my time in the military I resisted believing in military rituals and norms.'

labelled::var_label(data$wis_family_18) <- 'I miss my military friends.'
labelled::var_label(data$wis_family_19) <- 'I wish I could go back into the military.'
labelled::var_label(data$wis_family_20) <- 'By leaving the military I lost a family.'

labelled::var_label(data$wis_centrality_21) <- 'Overall, having served in the military has very little to do with how I feel about myself.'
labelled::var_label(data$wis_centrality_22) <- 'In general, being a veteran is an important part of my self-image.'
labelled::var_label(data$wis_centrality_23) <- 'Being a veteran is unimportant to my sense of what kind of person I am.'
labelled::var_label(data$wis_centrality_24) <- 'Being a veteran is not a major factor in my social relationships.'

labelled::var_label(data$wis_public_26) <- 'In general, others respect veterans and members of the military.'
labelled::var_label(data$wis_public_27) <- 'In general, other groups view veterans in a positive manner.'
labelled::var_label(data$wis_public_28) <- 'Society views veterans as an asset.'
labelled::var_label(data$wis_skills_29) <- 'I appreciate the skills I learned in the military.'
labelled::var_label(data$wis_skills_30) <- 'The work I do at home has more meaning for me than the work I did for the military.'
labelled::var_label(data$wis_skills_31) <- 'I miss the job related aspects of my time in the military.'
labelled::var_label(data$wis_public_25) <- 'Overall, veterans are highly thought of.'

labelled::var_label(data$attention_check_wis) <- 'For this question, respond with the answer Agree.'

labelled::var_label(data$scc_1) <- 'My beliefs about myself often conflict with one another.'
labelled::var_label(data$scc_2) <- 'On one day I might have one opinion of myself and on another day I might have a different opinion.'
labelled::var_label(data$scc_3) <- 'I spend a lot of time wondering about what kind of person I really am.'
labelled::var_label(data$scc_4) <- 'Sometimes I feel that I am not really the person that I appear to be.'
labelled::var_label(data$scc_5) <- 'When I think about the kind of person I have been in the past, I\'m not sure what I was really like.'
labelled::var_label(data$scc_6) <- 'I seldom experience conflict between the different aspects of my personality.'
labelled::var_label(data$scc_7) <- 'Sometimes I think I know other people better than I know myself.'
labelled::var_label(data$scc_8) <- 'My beliefs about myself seem to change very frequently.'
labelled::var_label(data$scc_9) <- 'If I were asked to describe my personality, my description might end up being different from one day to another day.'
labelled::var_label(data$scc_10) <- 'Even if I wanted to, I don\'t think I'
labelled::var_label(data$scc_11) <- 'In general, I have a clear sense of who I am and what I am.'
labelled::var_label(data$scc_12) <- "It is often hard for me to make up my mind about things because I don't really know what I want."

labelled::var_label(data$honeypot2) <- 'Did you serve in a military unit? - Yes'

labelled::var_label(data$mcarm_1) <- 'I have things that give me a sense of purpose, outside of paid employment.'
labelled::var_label(data$mcarm_2) <- 'I have interests and hobbies that are enjoyable or meaningful.'
labelled::var_label(data$mcarm_3) <- 'I have a sense of purpose.'
labelled::var_label(data$mcarm_4) <- 'I am fulfilled.'
labelled::var_label(data$mcarm_5) <- 'I feel I don’t belong anywhere.'
labelled::var_label(data$mcarm_6) <- 'Outside of the military, I have found people that I connect with through shared interests or beliefs.'
labelled::var_label(data$mcarm_7) <- 'I would ask for help if I needed it.'
labelled::var_label(data$mcarm_8) <- 'I would never seek help from a mental health professional.'
labelled::var_label(data$mcarm_9) <- 'I find it difficult to ask for help if I’m struggling.'
labelled::var_label(data$mcarm_10) <- 'I know how to access professional support for my health.'
labelled::var_label(data$mcarm_11) <- 'Civilians seem to be concerned with trivial matters.'
labelled::var_label(data$mcarm_12) <- 'Despite all my experience in the military, I am undervalued by civilians.'
labelled::var_label(data$mcarm_13) <- 'Civilians are disrespectful and rude.'
labelled::var_label(data$mcarm_14) <- 'I don’t think society puts much value on military service and experience.'
labelled::var_label(data$mcarm_15) <- 'I’m angry about the way I was treated during my service.'
labelled::var_label(data$mcarm_16) <- 'The military broke me and then kicked me out.'
labelled::var_label(data$mcarm_17) <- 'I have a lot of regrets about my service.'
labelled::var_label(data$mcarm_18) <- 'I am more regimented than flexible.'
labelled::var_label(data$mcarm_19) <- 'I find it difficult to change once I have a set routine.'
labelled::var_label(data$mcarm_20) <- 'I am a flexible person and I don’t mind changing to suit others when required.'
labelled::var_label(data$mcarm_21) <- 'Some of my military habits cause problems for me.'

labelled::var_label(data$m2cq_1) <- 'Dealing with people you do not know well (such as acquaintances or strangers)?'
labelled::var_label(data$m2cq_2) <- 'Making new friends?'
labelled::var_label(data$m2cq_3) <- 'Keeping up friendships with people who have no military experience?'
labelled::var_label(data$m2cq_4) <- 'Keeping up friendships with people who have military experiences (including friends who are active duty or veterans)?'
labelled::var_label(data$m2cq_5) <- 'Getting along with relatives (such as siblings, parents, grandparents, in-laws and children not living at home)?'
labelled::var_label(data$m2cq_6) <- 'Getting along with your spouse or partner (such as communicating, doing things together, enjoying his or her company)?'
labelled::var_label(data$m2cq_7) <- 'Getting along with your child or children (such as communicating, doing things together, enjoying his or her company)?'
labelled::var_label(data$m2cq_8) <- 'Finding or keeping a job (paid or nonpaid or self-employment)?'
labelled::var_label(data$m2cq_9) <- 'Doing what you need to do for work or school?'
labelled::var_label(data$m2cq_10) <- 'Taking care of your chores at home (such as housework, yard work, cooking, cleaning, shopping, errands)?'
labelled::var_label(data$m2cq_11) <- 'Taking care of your health (such as exercising, sleeping, bathing, eating well, taking medications as needed)?'
labelled::var_label(data$m2cq_12) <- 'Enjoying or making good use of free time?'
labelled::var_label(data$m2cq_13) <- 'Taking part in community events or celebrations (for example, festivals, PTA meetings, religious or other activities)?'
labelled::var_label(data$m2cq_14) <- 'Feeling like you belong in “civilian” society?'
labelled::var_label(data$m2cq_15) <- 'Confiding or sharing personal thoughts and feelings?'
labelled::var_label(data$m2cq_16) <- 'Finding meaning or purpose in life?'

labelled::var_label(data$honeypot3) <- 'What is 2 + 2?'

labelled::var_label(data$race_asian) <- 'What categories describe you? (select all that apply) - asian'
labelled::var_label(data$race_native) <- 'What categories describe you? (select all that apply) - native'
labelled::var_label(data$race_black) <- 'What categories describe you? (select all that apply) - black'
labelled::var_label(data$race_latino) <- 'What categories describe you? (select all that apply) - latino'
labelled::var_label(data$race_mena) <- 'What categories describe you? (select all that apply) - mena'
labelled::var_label(data$race_pacific) <- 'What categories describe you? (select all that apply) - pacific'
labelled::var_label(data$race_white) <- 'What categories describe you? (select all that apply) - white'
labelled::var_label(data$race_other) <- 'What categories describe you? (select all that apply) - other'

labelled::var_label(data$sex) <- 'What is your sex/gender? - Selected Choice'
labelled::var_label(data$sex_4_TEXT) <- 'What is your sex/gender? - Other - Text'
labelled::var_label(data$sexual_orientation) <- 'What is your sexual orientation? - Selected Choice'
labelled::var_label(data$sexual_orientation_6_TEXT) <- 'What is your sexual orientation? - A sexuality not listed above - Text'
labelled::var_label(data$religious) <- 'Do you consider yourself religious/spiritual? (Yes = 1, No = 0, Not Sure = NA'
labelled::var_label(data$worship) <- 'How often do you attend a place of worship? (e.g., church, temple, mosque)'
labelled::var_label(data$politics) <- 'What best describes your political affiliation?'
labelled::var_label(data$marital) <- 'What is your marital status?'

labelled::var_label(data$employment_full_time) <- 'What is your employment status? (select all that apply) - Full-Time'
labelled::var_label(data$employment_part_time) <- 'What is your employment status? (select all that apply) - Part-Time'
labelled::var_label(data$employment_irregular) <- 'What is your employment status? (select all that apply) - Irregular'
labelled::var_label(data$employment_unemployed) <- 'What is your employment status? (select all that apply) - Unemployed'
labelled::var_label(data$employment_retired) <- 'What is your employment status? (select all that apply) - Retired'
labelled::var_label(data$employment_student) <- 'What is your employment status? (select all that apply) - Student'

labelled::var_label(data$education) <- 'What is the highest level of school you have completed?'
labelled::var_label(data$job_like_military) <- 'How similar is your current job to the military?'

labelled::var_label(data$SC0) <- 'Meta Data: Score'
labelled::var_label(data$opp) <- 'Meta Data: opp'
labelled::var_label(data$ID) <- 'Meta Data: ID'
labelled::var_label(data$rid) <- 'Meta Data: rid'
labelled::var_label(data$RISN) <- 'Meta Data: RISN'
labelled::var_label(data$transaction_id) <- 'Meta Data: transaction_id'
labelled::var_label(data$SVID) <- 'Meta Data: SVID'
labelled::var_label(data$Q_BallotBoxStuffing) <- 'Meta Data: Q_BallotBoxStuffing'
labelled::var_label(data$gc) <- 'Meta Data: gc'
labelled::var_label(data$term) <- "The label given by the embedded survey logic. Indicates the way that someone screened out or was removed from the survey host quota"
labelled::var_label(data$V) <- 'Meta Data: V'
labelled::var_label(data$`Response Type`) <- 'Meta Data: Response Type. Test responses will indicate here'
labelled::var_label(data$LS) <- 'Meta Data: LS'
labelled::var_label(data$PS) <- 'Meta Data: PS'

# Validity and Attention Criteria  ---------------------------------------------------------
labelled::var_label(data$air_force_warrant_officer) <- "Warrant officer in the Air Force" 
labelled::var_label(data$validity_years) <- "Subtract 17 from years of age, then subtract years of service and separation. Negative numbers indicate inaccurate answers." 
labelled::var_label(data$invalid_years) <- "Are validity years less than 0?" 
labelled::var_label(data$psychant) <- "Psychometric Antonym Correlation" 
labelled::var_label(data$psychsyn) <- "Psychometric Synonym Correlation" 
labelled::var_label(data$longstr_no_reverse_scc) <- "Longest String Length: Self-Concept Clarity Scale without reverse scoring"
labelled::var_label(data$avgstr_no_reverse_scc) <- "Average String Length: Self-Concept Clarity Scale without reverse scoring" 
labelled::var_label(data$longstr_reverse_scc) <- "Longest String Length: Self-Concept Clarity Scale with reverse scoring"
labelled::var_label(data$avgstr_reverse_scc) <- "Average String Length: Self-Concept Clarity Scale with reverse scoring " 
labelled::var_label(data$longstr_mios) <- "Longest String Length: Moral Injury Outcomes Scale"
labelled::var_label(data$avgstr_mios) <- "Average String Length: Moral Injury Outcomes Scale" 
labelled::var_label(data$longstr_no_reverse_mcarm) <- "Longest String Length: Military-Civilian Adjustment and Reintegration Measure without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse_mcarm) <- "Average String Length: Military-Civilian Adjustment and Reintegration Measure without reverse scoring" 
labelled::var_label(data$longstr_reverse_mcarm) <- "Longest String Length: Military-Civilian Adjustment and Reintegration Measure with reverse scoring" 
labelled::var_label(data$avgstr_reverse_mcarm) <- "Average String Length: Military-Civilian Adjustment and Reintegration Measure with reverse scoring" 
labelled::var_label(data$longstr_m2cq) <- "Longest String Length: Military to Civilian Questionnaire with revese scoring" 
labelled::var_label(data$avgstr_m2cq) <- "Average String Length: Military to Civilian Questionnaire with revese scoring" 
labelled::var_label(data$longstr_no_reverse_biis) <- "Longest String Length: Bicultural Identity Integration Scale-2 without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse_biis) <- "Average String Length: Bicultural Identity Integration Scale-2 without reverse scoring" 
labelled::var_label(data$longstr_reverse_biis) <- "Longest String Length: Bicultural Identity Integration Scale-2 with reverse scoring" 
labelled::var_label(data$avgstr_reverse_biis) <- "Average String Length: Bicultural Identity Integration Scale-2 with reverse scoring" 
labelled::var_label(data$longstr_no_reverse) <- "Longest String Length: Entire Survey without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse) <- "Average String Length: Entire Survey with reverse scoring" 
labelled::var_label(data$longstr_reverse) <- "Longest String Length: Entire Survey with reverse scoring" 
labelled::var_label(data$avgstr_reverse) <- "Average String Length: Entire Survey with reverse scoring" 
labelled::var_label(data$evenodd) <- "Even-Odd Consistency" 


labelled::var_label(data$never_married) <- "Marital Status: Never Married"
labelled::var_label(data$married) <- "Marital Status: Married or living with a Partner"
labelled::var_label(data$divorced) <- "Marital Status: Divorced or Separated"
labelled::var_label(data$widowed) <- "Marital Status: Widowed"

labelled::var_label(data$sex_female) <- "Sex: Female"
labelled::var_label(data$sex_male) <- "Sex: Male"
labelled::var_label(data$sex_nonbinary) <- "Sex: Nonbinary"
labelled::var_label(data$sex_other) <- "Sex: Other"

labelled::var_label(data$sexual_orientation) <- "What is your sexual orientation?"
labelled::var_label(data$sexual_orientation_straight) <- "Sexual Orientation: Straight or Heterosexual"                                            
labelled::var_label(data$sexual_orientation_gay) <- "Sexual Orientation: Gay or Homosexual"
labelled::var_label(data$sexual_orientation_bi) <- "Sexual Orientation: Bisexual"
labelled::var_label(data$sexual_orientation_other) <- "Sexual Orientation: Other"
labelled::var_label(data$validity_years) <- "Years of Age minus 17, years of service, and years of separation"

# Service Era -------------------------------------------------------------
labelled::var_label(data$service_era) <- "Service Era"
labelled::var_label(data$service_era_post_wwii) <- "Served in the post-WWII era"
labelled::var_label(data$service_era_korea) <- "Served in the Korean era"
labelled::var_label(data$service_era_cold_war) <- "Served in the Cold War era"
labelled::var_label(data$service_era_vietnam) <- "Served in the Vietnam era"
labelled::var_label(data$service_era_persian_gulf) <- "Served in the Persian Gulf (pre-9/11) era"
labelled::var_label(data$service_era_post_911) <- "Served in the post-9/11 era"
labelled::var_label(data$service_era_multiple) <- "Served in multiple service eras"

# Totals



## b-IPF
labelled::var_label(data$bipf_total) <- "b-IPF Total Score (7 items)"
labelled::var_label(data$bipf_none) <- "Score of 0 on the b-IPF"

## Civilian Commitment
labelled::var_label(data$civilian_commit_total) <- "Civilian Identity Commitment Total Score (4 items)"

## M2CQ
labelled::var_label(data$m2cq_mean) <- "Military to Civilian Questionnaire Mean Score (16 items; some can be scored as NA)"

## M-CARM
labelled::var_label(data$mcarm_purpose_connection) <- "M-CARM Purpose Subscale Score (6 items)"
labelled::var_label(data$mcarm_help_seeking) <- "M-CARM Help Seeking Subscale Score (4 items)"
labelled::var_label(data$mcarm_beliefs_about_civilians) <- "M-CARM Beliefs About Civilians Subscale Score (3 items)"
labelled::var_label(data$mcarm_resentment_regret) <- "M-CARM Resentment and Regret Subscale Score (3 items)"
labelled::var_label(data$mcarm_regimentation) <- "M-CARM Regimentation Subscale Score (5) items"
labelled::var_label(data$mcarm_total) <- "M-CARM Total Score (21 items)"

labelled::var_label(data$pc_ptsd_positive_screen) <- "Probable PTSD based on scoring of PC-PTSD-5"
labelled::var_label(data$pc_ptsd_symptoms_total) <- "Score on the PC-PTSD-5"
labelled::var_label(data$pc_ptsd_symptoms_any) <- "One or more PTSD symptom reported on PC-PTSD-5"

labelled::var_label(data$age_enlisted) <- "Age entered the military. Calculated by years separated and years served."
labelled::var_label(data$age_separated) <- "Age separated from the military. Calculated by years separated."
labelled::var_label(data$age_enlisted) <- "?"

## MIOS 
labelled::var_label(data$mios_shame) <- "Moral Injury Outcomes Scale Shame Subscale Score (7 items)"
labelled::var_label(data$mios_trust) <- "Moral Injury Outcomes Scale Total Trust Violation Subscale Score (7 items)"
labelled::var_label(data$mios_total) <- "Moral Injury Outcomes Scale Shame Subscale Score (14 items)"
labelled::var_label(data$trauma_type) <- "Combination of moral injury event and PTSD criterion A event"


## SCC
labelled::var_label(data$scc_total) <- "Self-Concept Consistency Scale Total Score (12 items)"

## Unmet Discharge Needs
labelled::var_label(data$unmet_needs_total) <- "Number of Unmet Needs when leaving the military (9 items)"
labelled::var_label(data$unmet_needs_any) <- "Had at least one unmet need at discharge"

## WIS
labelled::var_label(data$wis_private_regard_total) <- "WIS Private Regard Subscale Score (7 items)"
labelled::var_label(data$wis_interdependent_total) <- "WIS Independent Subscale Score (7 itmes)"
labelled::var_label(data$wis_connection_total) <- "WIS Connection Subscale Score (3 items)"
labelled::var_label(data$wis_family_total) <- "WIS Family Subscale Score (3 items)"
labelled::var_label(data$wis_centrality_total) <- "WIS Centrality Subscale Score (4 items)"
labelled::var_label(data$wis_public_regard_total) <- "WIS Public Regard Subscale Score (4 items)"
labelled::var_label(data$wis_skills_total) <- "WIS Skills Subscale Score (3 items)"  
labelled::var_label(data$wis_total) <- "WIS Sum Score across all subscales"  




# -------------------------------------------------------------------------

# Write Codebook ----------------------------------------------------------

labels <- tibble::enframe(sjlabelled::get_label(data))

labels %>% print(n = 500)

labels %>% write_csv('output/codebook.')

message('Codebook updated')

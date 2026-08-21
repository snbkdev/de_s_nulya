************************************ Dimensional Modeling ************************************
************************************ Первый вариант ************************************

FCT_PAYMENT:
payment_id
amount
course_id   (FK -> DIM_COURSE.course_id)
payment_dttm
is_full_fg
full_shr
student_id  (FK -> DIM_STUDENT_ACT.student_id)

DIM_COURSE:
course_id(PK)
name
difficulty_lvl
requirements_fig
description
from_whom
headliner_id    (FK -> DIM_LECTOR.lector_id)
valid_from_dttm(PK)
valid_to_dttm

DIM_STUDENT_ACT:
student_id(PK)
gender
age_lvl
region
salary_lvl
profession_type

DIM_STUDENT_HIST:
student_id(PK)
gender
age_lvl
region
salary_lvl
profession_type
valid_from_dttm(PK)
valid_to_dttm

DIM_LECTOR:
lector_id(PK)
FIO
profession
company_prev
company

FCT_WATCHING:
student_id(PK)
lecture_id(PK)
start_dttm(PK)
duration
end_dttm
full_flg

DIM_LECTURE:
lecture_id(PK)
name
course_id
difficulty_lvl
description
lector_id   (FK -> dim_lector.lector_id)
valid_from_dttm
valid_to_dttm

DM_PAYMENT:
payment_id
amount
payment_dttm
is_full_fg
course_name
course_from_whom
course_description
course_requirements_flg
course_difficulty_lvl
headliner_company
headliner_profession
headliner_fio
student_salary_lvl
student_region
student_profession_type
student_age_lvl
student_gender
student_name

************************************ Dimensional Modeling ************************************
************************************ Второй вариант ************************************

STUDENT:
student_id(PK)
FIO
profession
company
gender
region_id   (FK -> REGION.region_id)
age_lvl
salary_lvl

REGION:
region_id(PK)
name
description
population

COURSE:
course_id(PK)
name
description
difficulty_lvl
from_whom
target_profession
duration
lector_id    (FK -> LECTOR.lector_id)

BLOCK:
block_id(PK)
name
description
difficulty_lvl
course_id   (FK -> COURSE.course_id)
duration
lector_id    (FK -> LECTOR.lector_id)

LECTION:
lection_id(PK)
name
description
difficulty_lvl
block_id    (FK)
duration
lector_id    (FK -> LECTOR.lector_id)

BLOCK_LECTION:
lection_id  (FK -> LECTION.lection_id)
block_id    (FK -> BLOCK.block_id)

LECTOR:
lector_id(PK)
fio
company
profession
skills

VIDEO_WATCHING
student_id  (PK -> STUDENT.student_id)
lection_id  (PK -> LECTION.lection_id)
start_dttm  (PK)
duration
full_flg

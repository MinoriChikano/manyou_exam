# README

1.users table
 ・ id:integer
 ・ name:string
 ・ email:string
 ・ passward_digest: string
 
 
2.tasks table
 ・ id:integer
 ・ user_id (FK)
 ・ task_name:string
 ・ detail:text
 ・ priority:string 
 ・ status:string

3.labels table
 ・ id:integer
 ・ user_id (FK)
 ・ create_table
 ・ title:string
 ・ remark:text



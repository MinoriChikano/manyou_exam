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


herokuデプロイ実行手順

1.heroku create
2.gemを追加 gem 'net-smtp' gem 'net-imap' gem 'net-pop'
3.git add .
4.git commit -m “コメント”
5.$ heroku buildpacks:set heroku/ruby
6.$ heroku buildpacks:add --index 1 heroku/nodejs
7.$ heroku addons:create heroku-postgresql
8.$ git push heroku (ブランチ名):master

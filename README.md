# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

 create_table "users"
    t.string "name"
    t.text "email"
    t.text "password_digest"
 end
 
 create_table "tasks"
    t.string "title"
    t.text "detail"
    t.integer "priority"
    t.text "status"
 end

 create_table "labels"
    t.string "title"
    t.text "remark"
 end


#!/bin/bash

db_localhost=localhost
db_user=postgres
db_pass=fahri5454
db_name=postgres

inotifywait -m -e create -e delete --format '%e %f' /home/fahricskn/Masaüstü/bsm | while read file; do

  time=$(date -Iseconds)

  if [[ $file = "CREATE" ]]; then

    psql -h $db_localhost -U $db_user -d $db_name -c "INSERT INTO newtablo (name, olusturulmaT) VALUES ('$(echo "$file" | cut -d' ' -f2)', '$time');"
  elif [[ $file = "DELETE" ]]; then

    psql -h $db_localhost -U $db_user -d $db_name -c "UPDATE newtablo SET silinme=true, silinmeT='$time' WHERE name='$(echo "$file" | cut -d' ' -f2)';"
  fi
done

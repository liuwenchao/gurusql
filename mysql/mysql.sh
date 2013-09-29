#!/bin/bash
#
# A shell script to run sql statment in shorter commands
# for MySQL.
#
# @author Louis<louis.wenchao.liu@gmail.com>
# @see https://github.com/liuwenchao/sql_guru
# @license MIT


# require: user, pass, db
source .my.cnf
: ${user:="root"}
: ${pass:="root"}
: ${db:="test"}
echo "login by: mysql $db -u$user -p$pass"

#
while read -p 'SQL> ' line
do
  case $line in
    "q")
      echo "dash out."
      break;;
    "h"|"help") 
      echo "see the source code, you are a guru.";;
    *)
      c=($(echo $line))
      op=${c[0]}
      table=${c[1]}
      param=${c[2]}
      case $op in
        "l") sql="select * from $table;";;
        "c") sql="select count(*) from $table;";;
        "g") sql="select $param, count(*) from $table group by $param;";;
        *)   sql=$x;;
      esac
      echo "$sql"
      eval "mysql $db -u$user -p$pass -e '$sql' "
      echo
      ;;
  esac
done
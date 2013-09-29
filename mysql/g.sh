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
: ${password:="root"}
: ${database:="test"}
: ${database:="test"}
: ${host:="localhost"}
echo "will login by: mysql $database -u$user -p$password"

#
while read -p "$user@host:$database> " line
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
      : ${param:="1=1"}
      case $op in
        "d") sql="desc $table;";;
        "s") sql="show create table $table;";;
        "l") sql="select * from $table where $param;";;
        "c") sql="select count(*) from $table where $param;";;
        "g") sql="select $param, count(*) from $table group by $param;";;
        "del") sql="delete from $table where $param;";;
        *)   sql=$x;;
      esac
      echo "$sql"
      eval "mysql $database -u$user -p$password -e '$sql' "
      echo
      ;;
  esac
done

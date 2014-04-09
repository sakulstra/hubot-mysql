# Description:
#   Tell people hubot's new name if they use the old one
#
# Dependencies:
#   "mysql": "*"
#   "moment": "*"
#
# Configuration:
#   MYSQL_HOST
#   MYSQL_USER
#   MYSQL_PASSWORD
#   MYSQL_DATABASE
#   MYSQL_TABLE
#
# Commands:
#   None
#
module.exports = (robot) ->
  robot.hear /(.+)/i, (msg) ->
    return if !msg.message.text or msg.message.text == 0 or msg.message.text[0] == '!' or msg.message.user.name == 'NickServ'
    moment = require 'moment'
    mysql = require 'mysql'
    connection = mysql.createConnection {
      host: process.env.MYSQL_HOST,
      user: process.env.MYSQL_USER,
      password: process.env.MYSQL_PASSWORD,
      database: process.env.MYSQL_DATABASE
    }
    row =
      username: msg.message.user.name
      message: msg.message.text
      created: moment().utc().format 'YYYY-MM-DD HH:mm::ss'
    query = connection.query 'INSERT INTO ' + process.env.MYSQL_TABLE + ' SET ?', row, (err, result) ->
      #done
    return
source ~/.bash_profile

source $commonConfigurationFilePath

dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

CREATE TABLE  IF NOT EXISTS feature_rule (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  feature varchar(20) DEFAULT '',
  grace_action varchar(20) DEFAULT '',
  name varchar(50) DEFAULT NULL,
  post_grace_action varchar(20) DEFAULT '',
  rule_order int DEFAULT '0',
  user_type varchar(20) DEFAULT '',
  failed_rule_action_grace varchar(10) DEFAULT '',
  failed_rule_action_post_grace varchar(10) DEFAULT '',
  output varchar(5) DEFAULT '',
  rule_message varchar(1000) DEFAULT '',
  modified_by varchar(50) DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY Unx_frule (feature,name)
);

 CREATE TABLE IF NOT EXISTS rule (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  description varchar(2500) DEFAULT '',
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  name varchar(50) DEFAULT '',
  output varchar(5) DEFAULT '',
  state varchar(20) DEFAULT '',
  modified_by varchar(30) DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY Unx_rule (name)
);

EOFMYSQL

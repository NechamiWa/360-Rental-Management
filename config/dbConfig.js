const dbConfig = {}

dbConfig.db_host = process.env.DB_HOST;
dbConfig.db_port = process.env.DB_PORT;
dbConfig.db_user = process.env.DB_USER;
dbConfig.db_database = process.env.DB_DATABASE;
dbConfig.db_password = process.env.DB_PASSORD;

module.exports = dbConfig;
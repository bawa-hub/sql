# start server
sudo systemctl start mongod
# check status
sudo systemctl status mongod

# start mongo command line
mongosh

# import json collections
mongoimport --db <db_name> --collection <collections_name> --file <json_file_name>
mongoimport --db stocks --collection stocks --file stocks.json

# helpful commands
help

# https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
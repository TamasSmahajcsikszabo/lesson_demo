library(neo4r)
library(TNG)

con <- neo4j_api$new(
    url = "http://localhost:7474",
    user = "neo4j",
    password = "Password1984"
)


con$get_version()

# Exercise 1.
# Check you are authenticated to use neo4j.
auth_status <- 400 # change this to the proper value
auth_status <- 200
con$ping() == auth_status
con$labels
ping <- call_neo4j("RETURN 1",con, type = "row")
print(ping)

# Exercise 2.
# Observe the structure of 'con' R6 object
print(str(con))

# get data from DB
con$get_relationships()
con$get_labels()

# send data
on_load_query <- 'CREATE (n:Product)
  SET n = row,
  n.unitPrice = toFloat(row.unitPrice),
  n.unitsInStock = toInteger(row.unitsInStock), n.unitsOnOrder = toInteger(row.unitsOnOrder),
  n.reorderLevel = toInteger(row.reorderLevel), n.discontinued = (row.discontinued <> "0");'

load_csv(url = file.path(getwd(), 'data', 'TNG.csv'), 
         con = con, header = TRUE, periodic_commit = 50, 
         as = "row", on_load = on_load_query)

query <- '
MATCH (c:Character)-[r]->(n)
RETURN c.name AS Character, type(r) AS Relationship, labels(n) AS Node, n
ORDER BY c.name;
'

# Execute the query
characters <- call_neo4j(query,con, type = "row")

# View the results
print(characters)

library(httr)
rs <- GET("http://localhost:7474")
status_code(GET("http://localhost:7474"))

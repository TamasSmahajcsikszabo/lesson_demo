from neo4j import GraphDatabase, RoutingControl


URI = "neo4j://localhost:7687"
AUTH = ("neo4j", "password")

def print_friends(driver, name):
    records, _, _ = driver.execute_query(
        "MATCH p=()-[r:PART_OF_EPISODE]->() RETURN p LIMIT 25",
        name=name, database_="neo4j", routing_=RoutingControl.READ,
    )
    for record in records:
        print(record)


with GraphDatabase.driver(URI, auth=AUTH) as driver:
    print(driver)

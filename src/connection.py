from neo4j import GraphDatabase, RoutingControl
import pandas as pd


URI = "neo4j://localhost:7687"
AUTH = ("neo4j", "Password1984")

query = ''' MATCH (c:Character)-[:IN_SCENE]->(s:Scene)-[:PART_OF_EPISODE]->(e:Episode)
RETURN e.title AS Episode, c AS CharacterCount
ORDER BY CharacterCount DESC;'''

def get_data(driver):
    records, _, _ = driver.execute_query(
        query, database_="neo4j", routing_=RoutingControl.READ,
    )
    for record in records:
        print(record)

if __name__ == '__main__':
    with GraphDatabase.driver(URI, auth=AUTH) as driver:
        get_data(driver)

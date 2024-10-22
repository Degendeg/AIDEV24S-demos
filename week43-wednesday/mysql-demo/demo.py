import mysql.connector

def fetch_all_from_table(table):
    try:
        # Skapa en conn till db
        connection = mysql.connector.connect(
            host="localhost",       # t.ex. 'localhost'
            user="root",            # t.ex. 'root'
            password="pappa444",    # t.ex. 'password'
            database="test_db"      # t.ex. 'my_database'
        )
        
        # Skapa cursor objekt för att köra SQL-frågor
        cursor = connection.cursor()
        
        # SQL-fråga för att hämta allt från tabellen
        cursor.execute(f"SELECT * FROM {table}")
        
        # Hämta alla rader
        rows = cursor.fetchall()
        
        # Stäng anslutningen
        cursor.close()
        connection.close()
        
        return rows

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

res = fetch_all_from_table("auction")

if res:
    for r in res:
        print(r)
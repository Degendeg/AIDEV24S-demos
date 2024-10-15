import sqlite3

# Create a new SQLite database
conn = sqlite3.connect('/mnt/data/example.db')
c = conn.cursor()

# Create a table 'students'
c.execute('''CREATE TABLE students (
              id INTEGER PRIMARY KEY, 
              name TEXT
            )''')

# Insert example data
students = [
    ('John Doe',),
    ('Alice Smith',),
    ('Bob Johnson',),
    ('Charlie Brown',)
]

c.executemany("INSERT INTO students (name) VALUES (?)", students)

# Commit and close connection
conn.commit()
conn.close()

"/mnt/data/example.db"
import sqlite3
import tkinter as tk
from tkinter import ttk, scrolledtext

def describe_db(db_name):
    conn = sqlite3.connect(db_name)
    c = conn.cursor()

    # Fetch all tables
    c.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = c.fetchall()

    output_text = ""

    output_text += "Tables in the db:\n"
    for table in tables:
        table_name = table[0]
        output_text += f"'{table_name}'\n\n"
        output_text += f"Descr of '{table_name}' table:\n"
        
        # Get table structure
        c.execute(f"PRAGMA table_info({table_name});")
        columns = c.fetchall()
        
        # Print table structure
        for column in columns:
            output_text += f"{column}\n"
        
        # Fetch and print all data in the table
        output_text += f"\nAll data in '{table_name}':\n"
        c.execute(f"SELECT * FROM {table_name}")
        rows = c.fetchall()
        for row in rows:
            output_text += f"{row}\n"

        output_text += "\n"  # Separate tables

    conn.close()

    return output_text

def display_db_info():
    # Get db info and update the text widget
    db_info = describe_db('example.db')
    text_area.delete(1.0, tk.END)  # Clear previous content
    text_area.insert(tk.INSERT, db_info)

def exit():
    root.quit()
    root.destroy()

# Setup Tk
root = tk.Tk()
root.title("SQLite Database Viewer")

# Set dark mode bg and foreground (text) colors
root.configure(bg='#2E2E2E')  # Dark gray
root.option_add('*TButton*Foreground', 'white')

# Create a dark-themed scrollbar
style = ttk.Style()
style.theme_use('clam')
style.configure("Vertical.TScrollbar", background='#333333', arrowcolor='white', troughcolor='#444444')

# Create a scrolled text widget with a dark-themed scrollbar
text_area = scrolledtext.ScrolledText(root, width=60, height=20, wrap=tk.WORD,
                                      bg='#333333', fg='#ffffff', insertbackground='white', 
                                      highlightbackground='#444444', borderwidth=0)
text_area.pack(padx=10, pady=10)

# Btn frame
button_frame = tk.Frame(root, bg='#2E2E2E')
button_frame.pack(pady=10)

# Load btn
load_button = tk.Button(button_frame, text="Load db info", command=display_db_info,
                        bg='#444444', fg='#ffffff', activebackground='#555555', activeforeground='#ffffff')
load_button.pack(side=tk.LEFT, padx=5)

# Exit btn
exit_button = tk.Button(button_frame, text="Exit", command=exit,
                        bg='#444444', fg='#ffffff', activebackground='#555555', activeforeground='#ffffff')
exit_button.pack(side=tk.LEFT, padx=5)

# __ Start
root.mainloop()
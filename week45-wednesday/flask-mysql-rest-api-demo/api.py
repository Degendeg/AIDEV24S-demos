import os
import json
from dotenv import load_dotenv
from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)

load_dotenv()

app.config['MYSQL_HOST'] = os.getenv('DB_HOST')
app.config['MYSQL_USER'] = os.getenv('DB_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('DB_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('DB_NAME')

mysql = MySQL(app)

def load_api_docs():
    with open(os.path.join(app.root_path, 'api_docs.json')) as f:
        return json.load(f)

# API r00t
@app.route('/', methods=['GET'])
def get_root():
    api_docs = load_api_docs()
    return jsonify(api_docs)

# API to fetch all products
@app.route('/products', methods=['GET'])
def get_products():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM product")
    products = cursor.fetchall()
    return jsonify(products)

# API to fetch a single product by ID
@app.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM product WHERE product_id = %s", (product_id,))
    product = cursor.fetchone()
    if product:
        return jsonify(product)
    else:
        return jsonify({'error': 'Product not found'}), 404

# API to add a new product
@app.route('/products', methods=['POST'])
def add_product():
    data = request.json
    product_name = data.get('product_name')
    supplier_id = data.get('supplier_id')
    category_id = data.get('category_id')
    quantity_per_unit = data.get('quantity_per_unit')
    unit_price = data.get('unit_price')
    units_in_stock = data.get('unit_in_stock')

    cursor = mysql.connection.cursor()
    cursor.execute("""
        INSERT INTO Products (product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock))
    mysql.connection.commit()
    return jsonify({'message': 'Product added successfully'}), 201

# API to update an existing product
@app.route('/products/<int:product_id>', methods=['PUT'])
def update_product(product_id):
    data = request.json
    product_name = data.get('product_name')
    supplier_id = data.get('supplier_id')
    category_id = data.get('category_id')
    quantity_per_unit = data.get('quantity_per_unit')
    unit_price = data.get('unit_price')
    units_in_stock = data.get('unit_in_stock')

    cursor = mysql.connection.cursor()
    cursor.execute("""
        UPDATE Products
        SET product_name = %s, supplier_id = %s, category_id = %s, quantity_per_unit = %s, unit_price = %s, unit_in_stock = %s
        WHERE ProductID = %s
    """, (product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, product_id))
    mysql.connection.commit()
    return jsonify({'message': 'Product updated successfully'})

# API to delete a product
@app.route('/products/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM product WHERE product_id = %s", (product_id,))
    mysql.connection.commit()
    return jsonify({'message': 'Product deleted successfully'})

# Run the app
if __name__ == '__main__':
    app.run(debug=True)

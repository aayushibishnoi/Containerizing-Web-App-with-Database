from flask import Flask, request, jsonify
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host='mysql',  # Docker service name
            database='user_db',
            user='root',
            password='securepassword'
        )
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

@app.route('/add_user', methods=['POST'])
def add_user():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    
    if not name or not email:
        return jsonify({"error": "Name and email required"}), 400
    
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor()
            query = "INSERT INTO users (name, email) VALUES (%s, %s)"
            cursor.execute(query, (name, email))
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({"message": "User added successfully"}), 201
        except Error as e:
            return jsonify({"error": str(e)}), 500
    return jsonify({"error": "Database connection failed"}), 500

@app.route('/users', methods=['GET'])
def get_users():
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users")
            users = cursor.fetchall()
            cursor.close()
            connection.close()
            return jsonify(users), 200
        except Error as e:
            return jsonify({"error": str(e)}), 500
    return jsonify({"error": "Database connection failed"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

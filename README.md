# 5200-Database-Final-Project

This project is a full-stack web application that includes a Flask backend and a React frontend, connected to a MySQL database. Follow the instructions below to set up and run the project.

## Prerequisites

Before you begin, ensure you have the following installed:
- Python 3
- Node.js and npm
- MySQL

## Backend Setup

1. **Install Python dependencies**:

   Open your terminal and run the following commands to install the required Python packages:

   ```bash
   pip install Flask
   pip install Flask-SQLAlchemy
   pip install mysql-connector-python
   pip install flask-cors
   pip install werkzeug
   pip install flask-cors
2. **Install react dependencies**:
   ```bash
   npm install axios
   npm install react-router-dom
   npm install bootstrap
3. **Connect to database**:
In __app.py line 10__ make sure to switch <username> and <password> to your own username and password
   ```bash
   app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://<username>:<password>@localhost:3306/gamedatabase'
   ```

4. **Run server&application**:

   Run __backend server__
   ```bash
   python -m flask run
   ```
   Run __react app__
   ```bash
   npm start
   ```

5. **Test**:
   To test if you successfully connect to the database you can use Postman
   select GET and enter:
   ```bash
   http://127.0.0.1:5000/game
   ```
   then hit __send__ if game related data shows means you successfully connected.

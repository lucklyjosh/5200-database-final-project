from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:Wen%402200808@localhost:3306/gamedatabase'

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Model for the Publisher table
class Publisher(db.Model):
    publisher_id = db.Column(db.Integer, primary_key=True)
    publisher_name = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return '<Publisher %r>' % self.publisher_name
    

# Model for the general_ledger_accounts table
class GeneralLedgerAccount(db.Model):
    account_number = db.Column(db.Integer, primary_key=True)
    account_description = db.Column(db.String(50), unique=True, nullable=False)

    def __repr__(self):
        return '<GeneralLedgerAccount %r>' % self.account_description

# Create a new general ledger account
@app.route('/account', methods=['POST'])
def create_account():
    try:
        data = request.json
        new_account = GeneralLedgerAccount(account_number=data['account_number'], account_description=data['account_description'])
        db.session.add(new_account)
        db.session.commit()
        return jsonify({'message': 'General Ledger Account created successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
# Create the tables in the database (Comment this out in production)
# @app.before_first_request
# def create_tables():
#     db.create_all()

# Basic route to test the setup
@app.route('/')
def hello():
    return "Hello, World!"

# Create a new publisher
@app.route('/publisher', methods=['POST'])
def add_publisher():
    data = request.get_json()
    new_publisher = Publisher(publisher_name=data['publisher_name'])
    db.session.add(new_publisher)
    db.session.commit()
    return jsonify({'message': 'Publisher created successfully'}), 201

# Get all publishers
@app.route('/publishers', methods=['GET'])
def get_publishers():
    publishers = Publisher.query.all()
    return jsonify([{'publisher_id': p.publisher_id, 'publisher_name': p.publisher_name} for p in publishers])

# Get a single publisher by ID
@app.route('/publisher/<int:id>', methods=['GET'])
def get_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    return jsonify({'publisher_id': publisher.publisher_id, 'publisher_name': publisher.publisher_name})

# Update a publisher
@app.route('/publisher/<int:id>', methods=['PUT'])
def update_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    data = request.get_json()
    publisher.publisher_name = data['publisher_name']
    db.session.commit()
    return jsonify({'message': 'Publisher updated successfully'})

# Delete a publisher
@app.route('/publisher/<int:id>', methods=['DELETE'])
def delete_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    db.session.delete(publisher)
    db.session.commit()
    return jsonify({'message': 'Publisher deleted successfully'})

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

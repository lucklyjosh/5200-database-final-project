from flask import request, jsonify

from app import app, db
from models import Publisher
from models import Game

# Create a new publisher
@app.route('/publisher', methods=['POST'])
def create_publisher():
    try:
        data = request.json
        new_publisher = Publisher(name=data['name'])
        db.session.add(new_publisher)
        db.session.commit()
        return jsonify({'message': 'Publisher created successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# Get all publishers
@app.route('/publishers', methods=['GET'])
def get_publishers():
    publishers = Publisher.query.all()
    return jsonify([{'id': publisher.id, 'name': publisher.name} for publisher in publishers])

# Get a single publisher by ID
@app.route('/publisher/<int:id>', methods=['GET'])
def get_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    return jsonify({'id': publisher.id, 'name': publisher.name})

# Update a publisher
@app.route('/publisher/<int:id>', methods=['PUT'])
def update_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    data = request.json
    publisher.name = data['name']
    db.session.commit()
    return jsonify({'message': 'Publisher updated successfully'})

# Delete a publisher
@app.route('/publisher/<int:id>', methods=['DELETE'])
def delete_publisher(id):
    publisher = Publisher.query.get_or_404(id)
    db.session.delete(publisher)
    db.session.commit()
    return jsonify({'message': 'Publisher deleted successfully'})

# Get all games
@app.route('/game', methods=['GET'])
def get_games():
    try:
        games = Game.query.all()
        games_data = [{
            'game_id': game.game_id,
            'title': game.game_title,
            'release_date': game.release_date.isoformat() if game.release_date else None,
        } for game in games]
        return jsonify(games_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


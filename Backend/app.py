from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
CORS(app)

# Make sure enter your username and password here to connect database
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://username:password@localhost:3306/gamedatabase' 


app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

game_platform_table = db.Table('gameplatform',
    db.Column('game_id', db.Integer, db.ForeignKey('game.game_id'), primary_key=True),
    db.Column('platform_id', db.Integer, db.ForeignKey('platform.platform_id'), primary_key=True)
)

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
    
# Model for the Game table
class Game(db.Model):
    __tablename__ = 'game'
    game_id = db.Column(db.Integer, primary_key=True)
    game_title = db.Column(db.String(255), nullable=False)
    release_date = db.Column(db.Date)
    publisher_id = db.Column(db.Integer, db.ForeignKey('publisher.publisher_id'))
    publisher = db.relationship('Publisher', backref='games')
    genre_id = db.Column(db.Integer, db.ForeignKey('genre.genre_id'), nullable=False)
    platforms = db.relationship('Platform', secondary=game_platform_table, back_populates='games')
    game_images = db.relationship('GameImage', back_populates='game')
    favorited_by = db.relationship('UserFavoriteGames', back_populates='game')
    def __repr__(self):
        return f'<Game {self.game_title}>'

class Review(db.Model):
    __tablename__ = 'review'
    review_id = db.Column(db.Integer, primary_key=True)
    game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    review_text = db.Column(db.Text)
    review_date = db.Column(db.DateTime, default=db.func.current_timestamp())

class Rating(db.Model):
    __tablename__ = 'rating'
    rating_id = db.Column(db.Integer, primary_key=True)
    game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    rating_date = db.Column(db.DateTime, default=db.func.current_timestamp())

class Genre(db.Model):
    __tablename__ = 'genre'
    genre_id = db.Column(db.Integer, primary_key=True)
    genre_name = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return f'<Genre {self.genre_name}>'

class Platform(db.Model):
    __tablename__ = 'platform'
    platform_id = db.Column(db.Integer, primary_key=True)
    platform_name = db.Column(db.String(255), nullable=False)
    games = db.relationship('Game', secondary=game_platform_table, back_populates='platforms')
    def __repr__(self):
        return f'<Platform {self.platform_name}>'

class User(db.Model):
    __tablename__ = 'users'  
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False)
    password_hash = db.Column(db.String(255))
    favorite_games = db.relationship('UserFavoriteGames', back_populates='user')
class Image(db.Model):
    __tablename__ = 'images'
    image_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    image_address = db.Column(db.String(999), nullable=False)
    image_description = db.Column(db.Text)
    game_images = db.relationship('GameImage', back_populates='image')
    
    def __repr__(self):
        return f'<Image {self.image_id}>'
    
class GameImage(db.Model):
    __tablename__ = 'GameImage'
    game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), primary_key=True)
    image_id = db.Column(db.Integer, db.ForeignKey('images.image_id'), primary_key=True)
    game = db.relationship('Game', back_populates='game_images')
    image = db.relationship('Image', back_populates='game_images')

class UserFavoriteGames(db.Model):
    __tablename__ = 'userfavoritegames'  
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), primary_key=True)
    game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), primary_key=True)
    user = db.relationship('User', back_populates='favorite_games')
    game = db.relationship('Game', back_populates='favorited_by')

    def __repr__(self):
        return f'<UserFavoriteGames user_id={self.user_id}, game_id={self.game_id}>'




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

# Get all publisher
@app.route('/publisher', methods=['GET'])
def get_all_publishers():
    publisher = Publisher.query.all()
    return jsonify([{'publisher_id': p.publisher_id, 'publisher_name': p.publisher_name} for p in publisher])

# Get a single publisher by ID
@app.route('/publisher/<int:id>', methods=['GET'])
def get_publisher_by_id(id):
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

@app.route('/game', methods=['GET'])
def get_games():
    try:
        games = db.session.query(Game, Publisher, Platform).join(
            Publisher, Game.publisher_id == Publisher.publisher_id
        ).join(
            game_platform_table, Game.game_id == game_platform_table.c.game_id
        ).join(
            Platform, game_platform_table.c.platform_id == Platform.platform_id
        ).all()

        games_data = {}
        for game, publisher, platform in games:
            if game.game_id not in games_data:
                games_data[game.game_id] = {
                    'game_id': game.game_id,
                    'title': game.game_title,
                    'release_date': game.release_date.isoformat() if game.release_date else None,
                    'publisher_name': publisher.publisher_name,
                    'genre_id': game.genre_id,
                    'platforms': [],
                    'images': []
                }
            games_data[game.game_id]['platforms'].append(platform.platform_name)

            images = GameImage.query.filter_by(game_id=game.game_id).join(Image).all()
            for game_image in images:
                games_data[game.game_id]['images'].append({
                    'image_id': game_image.image.image_id,
                    'image_address': game_image.image.image_address,
                    'image_description': game_image.image.image_description
                })
        print(games_data)
        return jsonify(list(games_data.values())), 200
    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500


@app.route('/images', methods=['GET'])
def get_all_images():
    try:
        images = Image.query.all()
        images_data = [{'image_id': image.image_id, 'image_address': image.image_address, 'image_description': image.image_description} for image in images]
        return jsonify(images_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/game/<int:game_id>/images', methods=['GET'])
def get_game_images(game_id):
    try:
        game_images = GameImage.query.filter_by(game_id=game_id).join(Image, GameImage.image_id == Image.image_id).all()
        images_data = [{'image_id': gi.image.image_id, 'image_address': gi.image.image_address, 'image_description': gi.image.image_description} for gi in game_images]
        return jsonify(images_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500






@app.route('/signup', methods=['POST'])
def signup():
    try:
        data = request.json
        existing_user = User.query.filter_by(username=data['username']).first()
        if existing_user:
            return jsonify({'message': 'Username already exists'}), 400

        hashed_password = generate_password_hash(data['password'])
        new_user = User(username=data['username'], password_hash=hashed_password)
        db.session.add(new_user)
        db.session.commit()
        return jsonify({'message': 'User registered successfully', 'user_id': new_user.user_id}), 201
    except Exception as e:
        app.logger.error(f'Signup error: {e}') 
        return jsonify({'error': 'Signup failed'}), 500


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = User.query.filter_by(username=data['username']).first()
    if user and check_password_hash(user.password_hash, data['password']):
        return jsonify({'message': 'Login successful', 'user_id': user.user_id}), 200
    else:
        return jsonify({'message': 'Invalid credentials'}), 401



@app.route('/game/review', methods=['POST'])
def add_review():
    data = request.json
    if 'game_id' not in data:
        return jsonify({'error': 'Missing game_id'}), 400 
    new_review = Review(
        game_id=data['game_id'],
        user_id=data['user_id'],

        review_text=data['review_text']
    )
    db.session.add(new_review)
    db.session.commit()
    return jsonify({'message': 'Review added successfully'}), 201



@app.route('/game/review', methods=['GET'])
def get_reviews():

    reviews = Review.query.all()  
    return jsonify([review.to_dict() for review in reviews]) 

@app.route('/game/<int:game_id>/reviews', methods=['GET'])
def get_game_reviews(game_id):
    reviews = Review.query.filter_by(game_id=game_id).all()
    reviews_data = []
    for review in reviews:
        user = User.query.get(review.user_id)
        reviews_data.append({
            "username": user.username,
            "review_text": review.review_text,
            "review_id": review.review_id,
            "user_id": user.user_id
        })
    return jsonify(reviews_data)

# update review
@app.route('/review/<int:review_id>', methods=['PUT'])
def update_review(review_id):
    data = request.json
    review = Review.query.get_or_404(review_id)

    print("Received user_id:", data['user_id'])
    print("Review's user_id:", review.user_id)

    # Make sure only current user can edit or delete
    if str(review.user_id) != data.get('user_id'):
        return jsonify({'message': 'Unauthorized'}), 403
    
    review.review_text = data.get('review_text', review.review_text)
    db.session.commit()
    return jsonify({'message': 'Review updated successfully'})

@app.route('/review/<int:review_id>', methods=['DELETE'])
def delete_review(review_id):
    review = Review.query.get_or_404(review_id)
    data = request.get_json()
    
    # Log to check data
    print("Received user_id:", data.get('user_id'))
    print("Review's user_id:", review.user_id)

    if 'user_id' not in data or str(review.user_id) != data['user_id']:
        return jsonify({'message': 'Unauthorized'}), 403

    db.session.delete(review)
    db.session.commit()
    return jsonify({'message': 'Review deleted successfully'})

@app.route('/genres', methods=['GET'])
def get_genres():
    genres = Genre.query.all()
    genre_data = [{'genre_id': genre.genre_id, 'genre_name': genre.genre_name} for genre in genres]
    return jsonify(genre_data)

@app.route('/platforms', methods=['GET'])
def get_platforms():
    platforms = Platform.query.all()
    platform_data = [{'platform_id': platform.platform_id, 'platform_name': platform.platform_name} for platform in platforms]
    return jsonify(platform_data)

@app.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    users_data = [{'user_id': user.user_id, 'username': user.username} for user in users]
    return jsonify(users_data)

@app.route('/user/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = User.query.get_or_404(user_id)
    user_data = {'user_id': user.user_id, 'username': user.username}
    return jsonify(user_data)

# Add game to user library
@app.route('/user/<int:user_id>/add_favorite/<int:game_id>', methods=['POST'])
def add_game_to_favorites(user_id, game_id):
    try:
        new_favorite = UserFavoriteGames(user_id=user_id, game_id=game_id)
        db.session.add(new_favorite)
        db.session.commit()
        return jsonify({'message': 'Game added to favorites successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Get user library
@app.route('/user/<int:user_id>/favorites', methods=['GET'])
def get_user_favorite_games(user_id):
    try:
        favorite_games = UserFavoriteGames.query.filter_by(user_id=user_id).join(Game).join(Publisher).all()
        games_data = []
        for fg in favorite_games:
            game_images = GameImage.query.filter_by(game_id=fg.game.game_id).join(Image, GameImage.image_id == Image.image_id).all()
            images = [{'image_id': gi.image.image_id, 'image_address': gi.image.image_address, 'image_description': gi.image.image_description} for gi in game_images]
            games_data.append({
                'game_id': fg.game.game_id,
                'title': fg.game.game_title,
                'release_date': fg.game.release_date.isoformat() if fg.game.release_date else None,
                'publisher': fg.game.publisher.publisher_name if fg.game.publisher else None,
                'images': images
            })
        return jsonify(games_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/user/<int:user_id>/favorite/<int:game_id>', methods=['DELETE'])
def delete_favorite_game(user_id, game_id):
    favorite_game = UserFavoriteGames.query.filter_by(user_id=user_id, game_id=game_id).first()
    if favorite_game:
        db.session.delete(favorite_game)
        db.session.commit()
        return jsonify({'message': 'Favorite game deleted successfully'}), 200
    else:
        return jsonify({'error': 'Favorite game not found'}), 404

@app.route('/game/<int:game_id>/rate', methods=['POST'])
def rate_game(game_id):
    try:
        data = request.json
        user_id = data['user_id']
        rating = data['rating']
        existing_rating = Rating.query.filter_by(game_id=game_id, user_id=user_id).first()
        if existing_rating:
            existing_rating.rating = rating
        else:
            new_rating = Rating(game_id=game_id, user_id=user_id, rating=rating)
            db.session.add(new_rating)
    
        db.session.commit()
        return jsonify({'message': 'Rating updated successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/game/<int:game_id>/rating/<int:user_id>', methods=['GET'])
def get_rating(game_id, user_id):
    rating = Rating.query.filter_by(game_id=game_id, user_id=user_id).first()
    if rating:
        return jsonify({'rating': rating.rating}), 200
    else:
        return jsonify({'rating': 0}), 200 


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

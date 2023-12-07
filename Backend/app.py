from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
CORS(app)

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
    
# Model for the Game table
class Game(db.Model):
    __tablename__ = 'game'
    game_id = db.Column(db.Integer, primary_key=True)
    game_title = db.Column(db.String(255), nullable=False)
    release_date = db.Column(db.Date)
    # developer_name = db.Column(db.String(255), nullable=False)
    publisher_id = db.Column(db.Integer, nullable=False)
    # category_id = db.Column(db.Integer, nullable=False)
    genre_id = db.Column(db.Integer, db.ForeignKey('genre.genre_id'), nullable=False)

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
    rating_value = db.Column(db.Integer, nullable=False)
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

    def __repr__(self):
        return f'<Platform {self.platform_name}>'


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
        # Join the Game table with the Publisher table
        games = db.session.query(Game, Publisher).join(Publisher, Game.publisher_id == Publisher.publisher_id).all()
        games_data = [{
            'game_id': game[0].game_id,  # Accessing Game object
            'title': game[0].game_title,
            'release_date': game[0].release_date.isoformat() if game[0].release_date else None,
            'publisher_name': game[1].publisher_name,  # Accessing Publisher object
            'genre_id': game[0].genre_id
        } for game in games]
        return jsonify(games_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# 用户模型
class User(db.Model):
    __tablename__ = 'users'  
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    password_hash = db.Column(db.String(255))

@app.route('/signup', methods=['POST'])
def signup():
    data = request.json

    # 检查用户名是否已存在
    existing_user = User.query.filter_by(username=data['username']).first()
    if existing_user:
        return jsonify({'message': 'Username already exists'}), 400

    try:
        hashed_password = generate_password_hash(data['password'])
        new_user = User(username=data['username'], email=data['email'], password_hash=hashed_password)
        db.session.add(new_user)
        db.session.commit()
        return jsonify({'message': 'User registered successfully', 'user_id': new_user.user_id}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

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
        # rating=data['rating'],
        review_text=data['review_text']
    )
    db.session.add(new_review)
    db.session.commit()
    return jsonify({'message': 'Review added successfully'}), 201



@app.route('/game/review', methods=['GET'])
def get_reviews():
    # 实现获取评论的逻辑
    reviews = Review.query.all()  # 示例查询
    return jsonify([review.to_dict() for review in reviews])  # 假设 Review 有一个 to_dict 方法

@app.route('/game/<int:game_id>/reviews', methods=['GET'])
def get_game_reviews(game_id):
    # 这里假设你有一种方法来获取特定游戏的评论
    # 以及评论对应的用户信息（如用户名）
    reviews = Review.query.filter_by(game_id=game_id).all()
    reviews_data = []
    for review in reviews:
        user = User.query.get(review.user_id)
        reviews_data.append({
            "username": user.username,
            "review_text": review.review_text,
            "review_id": review.review_id,
            # "rating": review.rating,  # 如果有评分系统的话
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

    # 可以添加检查确保只有评论的作者可以更新它
    if str(review.user_id) != data.get('user_id'):
        return jsonify({'message': 'Unauthorized'}), 403
    
    review.review_text = data.get('review_text', review.review_text)
    db.session.commit()
    return jsonify({'message': 'Review updated successfully'})

@app.route('/review/<int:review_id>', methods=['DELETE'])
def delete_review(review_id):
    review = Review.query.get_or_404(review_id)
    data = request.get_json()
    
    # 添加日志打印以检查接收到的数据
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
    users_data = [{'user_id': user.user_id, 'username': user.username, 'email': user.email} for user in users]
    return jsonify(users_data)

@app.route('/user/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = User.query.get_or_404(user_id)
    user_data = {'user_id': user.user_id, 'username': user.username, 'email': user.email}
    return jsonify(user_data)


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

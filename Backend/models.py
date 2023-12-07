from app import db

class Publisher(db.Model):
    __tablename__ = 'publisher'
    id = db.Column(db.Integer, primary_key=True)
    publisher_name = db.Column(db.String(255), nullable=False)

class Game(db.Model):
    __tablename__ = 'game'
    game_id = db.Column(db.Integer, primary_key=True)
    game_title = db.Column(db.String(255), nullable=False)
    release_date = db.Column(db.Date)
    # developer_name = db.Column(db.String(255), nullable=False)
    publisher_id = db.Column(db.Integer, db.ForeignKey('publisher.publisher_id'), nullable=False)
    # category_id = db.Column(db.Integer, db.ForeignKey('category.category_id'), nullable=False)
    genre_id = db.Column(db.Integer, db.ForeignKey('genre.genre_id'), nullable=False)

    # Optional: Define relationships if you want to include related data
    # publisher = db.relationship('Publisher', backref='games')
    # ... similarly for category and genre




# class Review(db.Model):
#     review_id = db.Column(db.Integer, primary_key=True)
#     game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), nullable=False)
#     user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
#     rating = db.Column(db.Integer, nullable=False)
#     review_text = db.Column(db.Text)
#     review_date = db.Column(db.DateTime, default=db.func.current_timestamp())

# class Rating(db.Model):
#     rating_id = db.Column(db.Integer, primary_key=True)
#     game_id = db.Column(db.Integer, db.ForeignKey('game.game_id'), nullable=False)
#     user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
#     rating_value = db.Column(db.Integer, nullable=False)
#     rating_date = db.Column(db.DateTime, default=db.func.current_timestamp())
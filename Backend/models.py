from app import db

class Publisher(db.Model):
    __tablename__ = 'publisher'
    id = db.Column(db.Integer, primary_key=True)
    publisher_name = db.Column(db.String(255), nullable=False)


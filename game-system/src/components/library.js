import React, { useState, useEffect } from 'react';
import { Navbar, Nav, Container, Row, Col, Card, Modal, Button, Form } from 'react-bootstrap';

import { useNavigate } from 'react-router-dom';
import ReactStars from 'react-rating-stars-component';
import "./library.css"

const Library = () => {

    const [allGames, setAllGames] = useState([]); // Store all the games from database
    const [games, setGames] = useState([]); // Store games show on the library
    const [selectedGame, setSelectedGame] = useState(null); // Current selected game
    const [showModal, setShowModal] = useState(false);
    const [showAddModal, setShowAddModal] = useState(false);
    const [newGame, setNewGame] = useState({ title: '', imageUrl: '', description: '' });
    const [errorMessage, setErrorMessage] = useState('');
    const [rating, setRating] = useState(0); 
    const [comment, setComment] = useState("");// Comment
    const [reviews, setReviews] = useState([]); // Store review data

    const [editingReviewId, setEditingReviewId] = useState(null);
    const [editingReviewText, setEditingReviewText] = useState('');
    const currentUserID = localStorage.getItem('userId'); // Current user id
    const [genres, setGenres] = useState([]);
    const [platforms, setPlatforms] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedGenres, setSelectedGenres] = useState([]);
    const [filteredGames, setFilteredGames] = useState(allGames);
    const navigate = useNavigate();

    
    useEffect(() => {
        fetch('http://127.0.0.1:5000/game')
            .then(response => response.json())
            .then(data => {
                data.forEach(game => {
                    console.log(game.title + " image URL: ", game.images && game.images.length > 0 ? game.images[0].image_address : "No image");
                });
                if (Array.isArray(data)) {
                    console.log("Games:", data);
                    setAllGames(data);
                    data.forEach(game => {
                        console.log(`Game: ${game.title}, Platform: ${game.platform_name}`);
                    });
                } else {
                    console.error('Data is not an array:', data);
                }
            })
            .catch(error => console.error('Error:', error));

        // Get genre
        fetch('http://127.0.0.1:5000/genres')
            .then(response => response.json())
            .then(data => {
                console.log("Genres:", data);
                setGenres(data);
            })
            .catch(error => console.error('Error:', error));

        // Get platform
        fetch('http://127.0.0.1:5000/platforms')
            .then(response => response.json())
            .then(data => setPlatforms(data))
            .catch(error => console.error('Error:', error));
    }, []);


    const handleRatingChange = (newRating) => {

        setRating(newRating);
        handleSubmitRating(newRating);
        const game_id = selectedGame.game_id;
        const user_id = localStorage.getItem('userId');

        fetch(`http://127.0.0.1:5000/game/${game_id}/rate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ user_id, rating: newRating }),
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to submit rating');
                }
            })
            .then(data => {
                alert('Rating submitted successfully');
                console.log(data.message);
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error submitting rating: ' + error.message);
            });

    };

    const handleSubmitRating = async (ratingValue) => {
        const userId = localStorage.getItem('userId');
        const ratingData = {
            user_id: userId,
            rating: ratingValue,
            game_id: selectedGame.game_id,
        };

        try {
            const response = await fetch(`http://127.0.0.1:5000/game/${selectedGame.game_id}/rate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(ratingData)
            });

            const data = await response.json();
            if (response.ok) {
                console.log('Rating submitted successfully:', data);
            } else {
                console.error('Failed to submit rating:', data.error);
            }
        } catch (error) {
            console.error('Error submitting rating:', error);
        }
    };

    const fetchRating = (gameId, userId) => {
        fetch(`http://127.0.0.1:5000/game/${gameId}/rating/${userId}`)
            .then(response => response.json())
            .then(data => {
                if (data.rating !== undefined) {
                    setRating(data.rating);
                }
            })
            .catch(error => console.error('Error:', error));
    };

    useEffect(() => {
        const userId = localStorage.getItem('userId');
        if (selectedGame && userId) {
            fetchRating(selectedGame.game_id, userId);
        }
    }, [selectedGame]);



    const handleCommentChange = (event) => {
        setComment(event.target.value);
    };


    const handleSubmitComment = () => {
        console.log('Selected Game:', selectedGame);
        const userId = localStorage.getItem('userId');
        console.log('Current User ID:', userId);

        const gameData = {
            game_id: selectedGame.game_id,
            user_id: userId,
            review_text: comment,
        };
        if (gameData.game_id && gameData.user_id) {
            fetch('http://127.0.0.1:5000/game/review', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(gameData),
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Success:', data);
                    alert('Submitted successfully!');
                })
                .catch((error) => {
                    console.error('Error:', error);
                });

            // Reset the form fields
            setRating(0);
            setComment("");
        } else {
            console.error('Game ID or User ID is missing');
        }
    };




    const handleAccountClick = (action) => {
        if (action === 'logout') {
            localStorage.removeItem('userId');
            navigate('/login');
        }
        console.log(action);

    };

    const openModal = (game) => {
        const gameWithPlatforms = allGames.find(g => g.game_id === game.game_id);
        setSelectedGame(gameWithPlatforms);
        fetchReviews(game.game_id);
        setShowModal(true);
    };


    const closeModal = () => {
        setShowModal(false);
    }

    const handleAddGame = (game) => {
        // Check game if already in
        if (games.some((addedGame) => addedGame.game_id === game.game_id)) {
            // If it is send error
            setErrorMessage('This game is already in your library');
        } else {
            // if not add it
            setGames((prevGames) => [...prevGames, game]);
            handleAddGameToFavorites(game); // Add to user's info database table
            setShowAddModal(false);
            setErrorMessage('');
        }
    };


    const handleDeleteGame = (game) => {
        const userId = localStorage.getItem('userId');

        fetch(`http://127.0.0.1:5000/user/${userId}/favorite/${game.game_id}`, {
            method: 'DELETE',
        })
            .then(response => {
                if (response.ok) {
                    setGames(previousGames => previousGames.filter(g => g.game_id !== game.game_id));
                    console.log('Favorite game deleted successfully');
                } else {
                    throw new Error('Failed to delete the favorite game');
                }
            })
            .catch(error => console.error('Error:', error));
    };



    // show Game Modal
    const showAddGameModal = () => {
        setShowAddModal(true);
    };

    const fetchReviews = (gameId) => {
        fetch(`http://127.0.0.1:5000/game/${gameId}/reviews`)
            .then(response => response.json())
            .then(data => setReviews(data))
            .catch(error => console.error('Error:', error));
    };


    const deleteReview = (reviewId) => {
        const userId = localStorage.getItem('userId'); // Get current user id

        fetch(`http://127.0.0.1:5000/review/${reviewId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ user_id: userId })
        })
            .then(response => {
                if (response.ok) {
                    // successfully delete
                    alert('Review deleted successfully');
                } else {
                    // fail delete
                    alert('Failed to delete review');
                    console.error('Failed to delete review');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    };


    const startEdit = (review) => {
        setEditingReviewId(review.review_id);
        setEditingReviewText(review.review_text);
    };
    const submitEdit = () => {
        fetch(`http://127.0.0.1:5000/review/${editingReviewId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ review_text: editingReviewText, user_id: localStorage.getItem('userId') })
        })
            .then(response => {
                if (response.ok) {
                    alert('Review updated successfully');
                    setEditingReviewId(null);
                } else {
                    alert('Failed to update review');
                }
            })
            .catch(error => console.error('Error:', error));
    };



    useEffect(() => {
        const filterGames = () => {
            let filtered = allGames.filter(game =>
                game.title.toLowerCase().includes(searchTerm.toLowerCase())
            );
            if (selectedGenres.length > 0) {
                filtered = filtered.filter(game =>
                    selectedGenres.includes(game.genre_id)
                );
            }
            console.log("Filtered Games:", filtered);
            setFilteredGames(filtered);
        };

        filterGames();
    }, [searchTerm, selectedGenres, allGames]);

    const handleAddGameToFavorites = (game) => {
        const userId = localStorage.getItem('userId');
        console.log('Adding game to favorites:', game);
        fetch(`http://127.0.0.1:5000/user/${userId}/add_favorite/${game.game_id}`, {
            method: 'POST',
        })
            .then(response => {
                if (response.ok) {
                    alert('Game added to favorites successfully');
                } else {
                    alert('Failed to add game to favorites');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding game to favorites');
            });
    };


    useEffect(() => {
        const userId = localStorage.getItem('userId');
        if (userId) {
            fetch(`http://127.0.0.1:5000/user/${userId}/favorites`)
                .then(response => response.json())
                .then(data => {
                    setGames(data);
                })
                .catch(error => console.error('Error:', error));
        }
    }, []);



    return (
        <>
            {/* Nav bar*/}
            <Navbar bg="dark" variant="dark" expand="lg">
                <Container>
                    <Navbar.Brand href="#home">Game Library</Navbar.Brand>
                    <Nav>
                        <Nav.Link onClick={() => handleAccountClick('logout')}>Logout</Nav.Link>
                    </Nav>
                </Container>
            </Navbar>

            <Container className="my-3">
                <Button onClick={showAddGameModal}>Add Game</Button>
            </Container>

            <Container>
                <Row xs={1} md={2} lg={4} className="g-4 mt-3">
                    {games.map((game) => {
                        console.log(`Game: ${game.title}, Image URL: ${game.images && game.images.length > 0 ? game.images[0].image_address : 'No image'}`);

                        return (
                            <Col key={game.game_id} onClick={() => openModal(game)}>
                                <Card className="h-100 cursor-pointer game-card">
                                    {game.images && game.images.length > 0 &&
                                        <Card.Img variant="top" src={game.images[0].image_address} />
                                    }
                                    <Card.Body>
                                        <Card.Title>{game.title}</Card.Title>
                                    </Card.Body>
                                    {game.user_id === localStorage.getItem('userId') && (
                                        <div className="card-actions">
                                            <button onClick={() => handleDeleteGame(game)}>Delete</button>
                                        </div>
                                    )}
                                </Card>
                            </Col>
                        );
                    })}
                </Row>
            </Container>

            =



            {/* Add game window */}
            <Modal show={showAddModal} onHide={() => setShowAddModal(false)} centered>
                <Modal.Header closeButton>
                    <Modal.Title>Select a Game to Add</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {/* Search */}
                    <Form.Control
                        type="text"
                        placeholder="Search games"
                        value={searchTerm}
                        onChange={e => setSearchTerm(e.target.value)}
                        className="mb-3"
                    />
                    {/* Check box */}
                    <div className="mb-3">
                        {genres.map(genre => (
                            <Form.Check
                                key={genre.genre_id}
                                type="checkbox"
                                label={genre.genre_name}
                                onChange={e => {
                                    const updatedSelectedGenres = e.target.checked
                                        ? [...selectedGenres, genre.genre_id]
                                        : selectedGenres.filter(id => id !== genre.genre_id);
                                    setSelectedGenres(updatedSelectedGenres);
                                    console.log("Selected Genres:", updatedSelectedGenres);
                                }}
                            />
                        ))}
                    </div>
                    <ul>
                        {filteredGames.map((game) => (
                            <li key={game.game_id}>
                                {game.title} - {game.release_date}
                                {games.some((addedGame) => addedGame.game_id === game.game_id) ? (
                                    <span className="text-danger">This game is already in your library</span>
                                ) : (
                                    <Card.Footer className="d-flex justify-content-end">
                                        <Button onClick={() => handleAddGame(game)}>Add to Library</Button>
                                    </Card.Footer>
                                )}
                            </li>
                        ))}
                    </ul>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowAddModal(false)}>Close</Button>
                </Modal.Footer>
            </Modal>


            {/* Detail window */}
            <Modal show={showModal} onHide={closeModal} size="lg" centered>
                <Modal.Header closeButton>
                    <Modal.Title>{selectedGame?.title}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <p>{selectedGame?.description}</p>
                    <p>Release Date: {selectedGame?.release_date}</p>
                    <p>Publisher: {selectedGame?.publisher_name}</p>
                    <p>Platforms: {selectedGame?.platforms.join(", ")}</p>
                    <p>Current User ID: {currentUserID}</p>
                    <ReactStars
                        count={5}
                        onChange={handleRatingChange}
                        value={rating}
                        size={24}
                        activeColor="#ffd700"
                    />

                    <div className="reviews">
                        {reviews.map((review) => (
                            <div key={review.review_id} className="review-item">
                                <div className="review-content">
                                    <strong>{review.username}</strong>: {review.review_text}
                                </div>
                                {parseInt(review.user_id, 10) === parseInt(localStorage.getItem('userId'), 10) && (
                                    <div className="buttons-container">
                                        {review.review_id === editingReviewId ? (
                                            <>
                                                <textarea value={editingReviewText} onChange={(e) => setEditingReviewText(e.target.value)} />
                                                <Button onClick={submitEdit}>Submit</Button>
                                                <Button onClick={() => setEditingReviewId(null)}>Cancel</Button>
                                            </>
                                        ) : (
                                            <>
                                                <Button onClick={() => startEdit(review)}>Edit</Button>
                                                <Button variant="danger" onClick={() => deleteReview(review.review_id)}>Delete</Button>
                                            </>
                                        )}
                                    </div>
                                )}
                            </div>
                        ))}
                    </div>


                    <Form>
                        <Form.Group className="mb-3" controlId="comment">
                            <Form.Label>Comment</Form.Label>
                            <Form.Control as="textarea" rows={3} onChange={handleCommentChange} />
                        </Form.Group>
                        <Button variant="primary" onClick={handleSubmitComment}>
                            Submit Comment
                        </Button>
                    </Form>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="danger" onClick={() => handleDeleteGame(selectedGame)}>
                        Delete this game
                    </Button>
                    <Button variant="secondary" onClick={closeModal}>
                        Close
                    </Button>
                </Modal.Footer>
            </Modal>



        </>
    );
};

export default Library;

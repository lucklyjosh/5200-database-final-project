import React, { useState, useEffect } from 'react';
import { Navbar, Nav, NavDropdown, Container, Row, Col, Card, Modal, Button, Form } from 'react-bootstrap';
import defaultImage from './default.jpg'; // Adjust the path if your file structure is different
import { useNavigate } from 'react-router-dom';
import ReactStars from 'react-rating-stars-component';
import "./library.css"

const Library = () => {

    const [allGames, setAllGames] = useState([]); // 用于存储从数据库中获取的所有游戏
    const [games, setGames] = useState([]); // 用于存储用户界面上显示的游戏
    const [selectedGame, setSelectedGame] = useState(null); // 当前选中的游戏
    const [showModal, setShowModal] = useState(false); // 控制模态框的显示
    const [showGameModal, setShowGameModal] = useState(false);
    const [showAddModal, setShowAddModal] = useState(false); // 控制添加游戏模态框的状态
    const [newGame, setNewGame] = useState({ title: '', imageUrl: '', description: '' }); // 新游戏表单的状态
    const [errorMessage, setErrorMessage] = useState('');
    const [rating, setRating] = useState(0); // 状态变量用于存储评分
    const [comment, setComment] = useState("");// 状态变量用于存储评论
    const [reviews, setReviews] = useState([]); // 用于存储评论数据

    const [editingReviewId, setEditingReviewId] = useState(null);
    const [editingReviewText, setEditingReviewText] = useState('');
    const currentUserID = localStorage.getItem('userId'); // 获取当前用户ID

    useEffect(() => {
        fetch('http://127.0.0.1:5000/game')
            .then(response => response.json())
            .then(data => {
                if (Array.isArray(data)) {
                    setAllGames(data);
                } else {
                    console.error('Data is not an array:', data);
                }
            })
            .catch(error => console.error('Error:', error));
    }, []);
    

    const handleRatingChange = (newRating) => {
        setRating(newRating);
    };

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
            // rating: rating,
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
                    // You might want to update state or UI based on the successful submission
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

    const handleAddToLibrary = (game) => {
        // 检查游戏是否已在库中
        const isGameInLibrary = games.some((libraryGame) => libraryGame.game_id === game.game_id);

        if (isGameInLibrary) {
            alert('该游戏已在库中。');
            return;
        }

        // 添加游戏到用户界面
        setGames([...games, game]);
        setShowAddModal(false); // 关闭模态框
    };

    // 处理过滤器逻辑
    const handleFilter = (filterType) => {
        console.log(filterType);
        // 根据过滤类型更新游戏列表...
    };

    const navigate = useNavigate();
    // 处理用户头像点击事件
    const handleAccountClick = (action) => {
        if (action === 'logout') {
            localStorage.removeItem('userId');
            navigate('/login');
        }
        console.log(action);
        // 根据选择执行动作(如：退出登录、查看个人资料等)
    };






    // 打开模态窗口的函数，设置选中的游戏
    const openModal = (game) => {
        setSelectedGame(game);
        fetchReviews(game.game_id);
        setShowModal(true);
    };

    // 关闭模态窗口的函数
    const closeModal = () => {
        setShowModal(false);
    }

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNewGame({ ...newGame, [name]: value });
    };

    // 添加游戏的函数
    // const handleAddGame = () => {
    //     setGames([...games, { ...newGame, id: Date.now() }]); 
    //     setNewGame({ title: '', imageUrl: '', description: '' }); 
    //     setShowAddModal(false); 
    // };
    const handleAddGame = (game) => {
        // 检查游戏是否已经存在于库中
        if (games.some((addedGame) => addedGame.game_id === game.game_id)) {
            // 游戏已经存在，设置错误消息
            setErrorMessage('This game is already in your library');
        } else {
            // 游戏不存在，添加到用户的库中
            setGames((prevGames) => [...prevGames, game]); // 使用函数形式更新状态
            setShowAddModal(false); // 关闭模态框
            // 清除错误消息
            setErrorMessage('');
        }
    };

    const clearErrorMessage = () => {
        setErrorMessage('');
    };

    // 删除游戏的函数
    // const handleDeleteGame = (gameId) => {
    //     setGames(games.filter(game => game.id !== gameId));
    // };
    const handleDeleteGame = (game) => {
        // 检查游戏是否已在库中
        const isGameInLibrary = games.some((libraryGame) => libraryGame.game_id === game.game_id);

        if (!isGameInLibrary) {
            alert('该游戏不在库中。');
            return;
        }

        // 从用户界面中删除游戏
        setGames(games.filter((libraryGame) => libraryGame.game_id !== game.game_id));
    };

    // 更新游戏的函数
    const handleUpdateGame = (gameId) => {
        // 实现更新游戏的逻辑
        // 例如，打开一个表单模态窗口来修改游戏的信息
    };

    // 显示添加游戏模态框
    const showAddGameModal = () => {
        setShowAddModal(true);
    };

    // 确认删除游戏
    const confirmDeleteGame = (game) => {
        const confirmDelete = window.confirm(`确定要删除游戏 "${game.title}" 吗？`);
        if (confirmDelete) {
            handleDeleteGame(game.id);
        }
    };


    const fetchReviews = (gameId) => {
        fetch(`http://127.0.0.1:5000/game/${gameId}/reviews`)
            .then(response => response.json())
            .then(data => setReviews(data))
            .catch(error => console.error('Error:', error));
    };


    const deleteReview = (reviewId) => {
        const userId = localStorage.getItem('userId'); // 获取当前登录用户的ID
    
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

    return (
        <>
            {/* 导航栏 */}
            <Navbar bg="dark" variant="dark" expand="lg">
                <Container>
                    <Navbar.Brand href="#home">Game Library</Navbar.Brand>
                    {/* <Nav className="me-auto">
                        <Nav.Link href="#action">Action</Nav.Link>
                        <Nav.Link href="#adventure">Adventure</Nav.Link>
                    </Nav> */}
                    <Nav>
                        <NavDropdown title={<img src="/path-to-account-image.png" alt="Account" />} id="account-dropdown">
                            <NavDropdown.Item onClick={() => handleAccountClick('profile')}>Profile</NavDropdown.Item>
                            <NavDropdown.Item onClick={() => handleAccountClick('logout')}>Logout</NavDropdown.Item>
                        </NavDropdown>
                    </Nav>
                </Container>
            </Navbar>

            <Container className="my-3">
                <Button onClick={showAddGameModal}>Add Game</Button>
            </Container>

            {/* 游戏卡片 */}
            {/* <Container>
                <Row xs={1} md={2} lg={4} className="g-4 mt-3">
                    {games.map((game) => (
                        <Col key={game.id} onClick={() => openModal(game)}>
                            <Card className="h-100 cursor-pointer">
                                <Card.Img variant="top" src={game.imageUrl} />
                                <Card.Body>
                                    <Card.Title>{game.title}</Card.Title>
                                </Card.Body>
                            </Card>
                        </Col>
                    ))}
                </Row>
            </Container> */}
            <Container>
                <Row xs={1} md={2} lg={4} className="g-4 mt-3">
                    {games.map((game) => (
                        <Col key={game.game_id} onClick={() => openModal(game)}>
                            <Card className="h-100 cursor-pointer game-card">
                                <Card.Img variant="top" src={game.imageUrl || defaultImage} />
                                <Card.Body>
                                    <Card.Title>{game.title}</Card.Title>
                                    {/* 游戏其他信息 */}
                                </Card.Body>
                                {/* 假设 USER_ID 是当前登录用户的 ID */}
                                {game.user_id === localStorage.getItem('userId') && (
                                    <div className="card-actions">
                                        <button onClick={() => handleDeleteGame(game)}>Delete</button>
                                    </div>
                                )}
                            </Card>
                        </Col>
                    ))}
                </Row>
            </Container>



            {/* 添加游戏模态框 */}
            <Modal show={showAddModal} onHide={() => setShowAddModal(false)} centered>
                <Modal.Header closeButton>
                    <Modal.Title>Select a Game to Add</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <ul>
                        {allGames.map((game) => (
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



            {/* 
            <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowAddModal(false)}>Cancel</Button>
                    <Button variant="primary" onClick={handleAddGame}>Add Game</Button>
                </Modal.Footer> */}

            {/* 游戏详情模态窗口 */}
            <Modal show={showModal} onHide={closeModal} size="lg" centered>
                <Modal.Header closeButton>
                    <Modal.Title>{selectedGame?.title}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <p>{selectedGame?.description}</p>
                    <p>Release Date: {selectedGame?.release_date}</p>
                    <p>Publisher: {selectedGame?.publisher_name}</p>
                    <p>当前用户ID: {currentUserID}</p>
                    <ReactStars
                        count={5}
                        onChange={handleRatingChange}
                        size={24}
                        activeColor="#ffd700"
                    />
                    <div className="reviews">
                        {reviews.map((review) => (
                            <div key={review.review_id} className="review-item">
                                {/* 其他内容 */}
                                <strong>{review.username}</strong>: {review.review_text}
                                {/* <p>评论: {review.review_text} (用户ID: {review.user_id})</p> */}
                                {review.review_id === editingReviewId ? (
                                    <div>
                                        <textarea value={editingReviewText} onChange={(e) => setEditingReviewText(e.target.value)} />
                                        <Button onClick={submitEdit}>Submit</Button>
                                        <Button onClick={() => setEditingReviewId(null)}>Cancel</Button>
                                    </div>
                                ) : (
                                    <div>
                                        {/* <p>{review.review_text}</p> */}
                                        {parseInt(review.user_id, 10) === parseInt(localStorage.getItem('userId'), 10) && (
                                            <div className="buttons-container">
                                                <Button onClick={() => startEdit(review)}>Edit</Button>
                                                <Button variant="danger" onClick={() => deleteReview(review.review_id)}>Delete</Button>
                                            </div>
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
                        Delete
                    </Button>
                    <Button variant="primary" onClick={() => handleUpdateGame(selectedGame?.id)}>
                        Edit
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

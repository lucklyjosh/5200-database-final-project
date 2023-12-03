import React, { useState } from 'react';
import { Navbar, Nav, NavDropdown, Container, Row, Col, Card, Modal, Button, Form } from 'react-bootstrap';

const Library = () => {
    // 假设游戏数据存储在state或来自API调用
    const [games, setGames] = useState([
        { id: 1, title: 'Game 1', imageUrl: '/path-to-image-1.png', description: 'Game 1 Description' },
        // ...其他游戏数据
    ]);

    // 处理过滤器逻辑
    const handleFilter = (filterType) => {
        console.log(filterType);
        // 根据过滤类型更新游戏列表...
    };

    // 处理用户头像点击事件
    const handleAccountClick = (action) => {
        console.log(action);
        // 根据选择执行动作(如：退出登录、查看个人资料等)
    };

    // 选中游戏的状态
    const [selectedGame, setSelectedGame] = useState(null);
    // 控制模态窗口的状态
    const [showModal, setShowModal] = useState(false);

    const [showGameModal, setShowGameModal] = useState(false);
    const [showAddModal, setShowAddModal] = useState(false); // 控制添加游戏模态框的状态
    const [newGame, setNewGame] = useState({ title: '', imageUrl: '', description: '' }); // 新游戏表单的状态


    // 打开模态窗口的函数，设置选中的游戏
    const openModal = (game) => {
        setSelectedGame(game);
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
    const handleAddGame = () => {
        setGames([...games, { ...newGame, id: Date.now() }]); // 假设使用时间戳作为唯一ID
        setNewGame({ title: '', imageUrl: '', description: '' }); // 重置表单
        setShowAddModal(false); // 关闭模态框
    };

    // 删除游戏的函数
    const handleDeleteGame = (gameId) => {
        // 实现删除游戏的逻辑
        // 例如，更新state来移除游戏
        setGames(games.filter(game => game.id !== gameId));
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
    return (
        <>
            {/* 导航栏 */}
            <Navbar bg="dark" variant="dark" expand="lg">
                <Container>
                    <Navbar.Brand href="#home">Game Library</Navbar.Brand>
                    <Nav className="me-auto">
                        <Nav.Link href="#action">Action</Nav.Link>
                        <Nav.Link href="#adventure">Adventure</Nav.Link>
                        {/* 更多过滤类型 */}
                    </Nav>
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
            <Container>
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
            </Container>

            {/* 添加游戏模态框 */}
            <Modal show={showAddModal} onHide={() => setShowAddModal(false)} centered>
                <Modal.Header closeButton>
                    <Modal.Title>Add New Game</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Form>
                        <Form.Group className="mb-3" controlId="gameTitle">
                            <Form.Label>Game Title</Form.Label>
                            <Form.Control type="text" placeholder="Game Title" name="title" value={newGame.title} onChange={handleInputChange} />
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="gameImageUrl">
                            <Form.Label>Upload IMG URL</Form.Label>
                            <Form.Control type="text" placeholder="URL" name="imageUrl" value={newGame.imageUrl} onChange={handleInputChange} />
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="gameDescription">
                            <Form.Label>Game Description</Form.Label>
                            <Form.Control as="textarea" rows={3} placeholder="Description" name="description" value={newGame.description} onChange={handleInputChange} />
                        </Form.Group>
                    </Form>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowAddModal(false)}>Cancel</Button>
                    <Button variant="primary" onClick={handleAddGame}>Add Game</Button>
                </Modal.Footer>
            </Modal>


            {/* 游戏详情模态窗口 */}
            <Modal show={showModal} onHide={closeModal} size="lg" centered>
                <Modal.Header closeButton>
                    <Modal.Title>{selectedGame?.title}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <p>{selectedGame?.description}</p>
                    {/* 在这里添加更多游戏详情 */}
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="danger" onClick={() => handleDeleteGame(selectedGame?.id)}>
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

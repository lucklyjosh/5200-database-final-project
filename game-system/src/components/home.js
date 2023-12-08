import React from 'react';
import { Container, Button } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import './home.css'; // 一个新的 CSS 文件，用于添加自定义样式

function Home() {
  const navigate = useNavigate();

  const navigateToLogin = () => {
    navigate('/login');
  };

  const navigateToSignUp = () => {
    navigate('/signup');
  };

  return (
    <div className="home-background"> {/* 使用类来添加背景图片或视频 */}
      <Container className="text-center home-container"> {/* 添加一个居中的容器 */}
        <header className="home-header">
          <h1 className="display-1 home-title">Welcome to the Game Database</h1>
          <p className="lead home-subtitle">Manage your favourite games in one place.</p>

          <div className="home-buttons">
            <Button className="home-button" onClick={navigateToLogin}>Login</Button>
            <Button className="home-button" onClick={navigateToSignUp}>SignUp</Button>
          </div>
        </header>
      </Container>
    </div>
  );
}

export default Home;

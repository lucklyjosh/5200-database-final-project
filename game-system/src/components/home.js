import React from 'react';
import { Container, Button } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import './home.css'; 

function Home() {
  const navigate = useNavigate();

  const navigateToLogin = () => {
    navigate('/login');
  };

  const navigateToSignUp = () => {
    navigate('/signup');
  };

  return (
    <div className="home-background">
      <Container className="text-center home-container"> 
        <header className="home-header">
          <h1 className="display-1 home-title">Welcome to your Game Library</h1>
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

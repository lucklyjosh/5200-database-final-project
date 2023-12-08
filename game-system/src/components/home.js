import React from 'react';
import { Container, Button } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

function Home() {
  const navigate = useNavigate();
  const navigateToLogin = () => {
    navigate('/login');
  };

  const navigateToSignUp = () => {
    navigate('/signup');
  };
  return (
    <Container>
      <header className="p-5 text-center bg-light">
        <h1 className="display-1">Welcome to the Game Database</h1>
        <p className="lead">This is a simple application to manage your favourite games.</p>

        <div className="mt-2">
        <Button onClick={navigateToLogin}>Login</Button>
        </div>
        <div className="mt-2">
        <Button onClick={navigateToSignUp}>SignUp</Button>
        </div>
      </header>
    </Container>
  );
}

export default Home;

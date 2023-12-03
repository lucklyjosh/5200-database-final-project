import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useState } from "react";
import './login.css';

function Login() {
    const [user, setUser] = useState({ username: '', password: '' });
    const [error, setError] = useState('');
    const navigate = useNavigate();


    const navigateTolibrary = () => {
        // Implement login logic here
        navigate('/library'); // Navigate to game library after login
    };

    const signin = async () => {
    };

    return (
        <div className="p-5 text-center bg-light login-container">
            <h1>Signin</h1>
            {error && <div className="alert alert-danger">{error}</div>}

            <input
                value={user.username}
                onChange={(e) => setUser({ ...user, username: e.target.value })}
                placeholder="username"
                className="form-control mb-2 text-center login-input"
            />
            <input
                value={user.password}
                onChange={(e) => setUser({ ...user, password: e.target.value })}
                type="password"
                placeholder="password"
                className="form-control mb-2 text-center login-input"
            />
            <button onClick={navigateTolibrary} className="btn btn-primary w-20">
                Signin
            </button>


        </div>

    );
}

export default Login;

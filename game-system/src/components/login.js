import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useState } from "react";
import './login.css';

function Login() {
    const [user, setUser] = useState({ username: '', password: '' });
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const signup = async () => {
        navigate('/signup')
    }

    const signin = async () => {
        try {
            const response = await fetch('http://127.0.0.1:5000/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ username: user.username, password: user.password }),
            });

            const data = await response.json();
            if (response.ok) {
                localStorage.setItem('userId', data.user_id); // 确保这里使用的键名与读取时相同
                navigate('/library');
            
            } else {
                setError(data.message || 'Login failed');
            }
        } catch (error) {
            setError('Login failed. Please try again.');
        }
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
            <button onClick={signin} className="btn btn-primary w-20">
                Signin
            </button>

            <button onClick={signup} className="btn btn-primary w-20 mt-3">
                Signup
            </button>
        </div>

    );
}

export default Login;

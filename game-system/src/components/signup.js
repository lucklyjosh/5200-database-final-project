import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const SignUp = () => {
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();


    const handleSubmit = (event) => {
        event.preventDefault();
        // 发送请求到后端API进行注册
        fetch('http://127.0.0.1:5000/signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, email, password }),
        })
        .then(response => response.json())
        .then(data => {
            if (data.message === 'User registered successfully') {
                // 注册成功，跳转到登录页面
                navigate('/login'); 
            } else {
                // 处理错误，例如显示错误消息
                console.error('Signup failed:', data.message);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    };
    return (
<form onSubmit={handleSubmit} className="p-5 text-center bg-light login-container">
    <h1>Signup</h1>
    <div className="form-group mb-3">
        <input 
            type="text" 
            value={username} 
            onChange={(e) => setUsername(e.target.value)}
            className="form-control text-center"
            placeholder="Username"
        />
    </div>
    <div className="form-group mb-3">
        <input 
            type="email" 
            value={email} 
            onChange={(e) => setEmail(e.target.value)}
            className="form-control text-center"
            placeholder="Email"
        />
    </div>
    <div className="form-group mb-3">
        <input 
            type="password" 
            value={password} 
            onChange={(e) => setPassword(e.target.value)}
            className="form-control text-center"
            placeholder="Password"
        />
    </div>
    <button type="submit" className="btn btn-primary w-20">Sign Up</button>
</form>

        
    );
};

export default SignUp;

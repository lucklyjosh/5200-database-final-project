import React from 'react';
import { BrowserRouter as HashRouter, Route, Routes } from 'react-router-dom';
// import Home from './components/Home';
import Library from './components/library';
import Home from './components/home'
import Login from './components/login';
import 'bootstrap/dist/css/bootstrap.min.css';
import SignUp from './components/signup'; 


function App() {
  return (
    <HashRouter>
      <div>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<SignUp />} />
          <Route path="/library" element={<Library />} />
        </Routes>
      </div>

    </HashRouter>
  );
}

export default App;

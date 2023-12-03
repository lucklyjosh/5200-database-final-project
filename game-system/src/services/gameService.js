import axios from 'axios';

const API_URL = 'http://127.0.0.1:5000'; // 修改为您的Flask API URL

export const addGame = async (gameData) => {
    try {
        const response = await axios.post(`${API_URL}/game`, gameData);
        return response.data;
    } catch (error) {
        throw error;
    }
};

export const deleteGame = async (gameId) => {
    try {
        await axios.delete(`${API_URL}/game/${gameId}`);
    } catch (error) {
        throw error;
    }
};

export const updateGame = (id, gameData) => {
    try {
        axios.put(`${API_URL}/game/${id}`, gameData);
    } catch (error) {
        throw error;
    }
};

export const getAllGames = () => axios.get(`${API_URL}/games`);
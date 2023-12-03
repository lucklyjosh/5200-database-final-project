import React, { useState } from 'react';
import { addGame, deleteGame } from '../services/gameService';

function GameComponent() {
  const [gameName, setGameName] = useState('');

  const handleAddGame = async () => {
    try {
      await addGame({ name: gameName });
      alert('Game added successfully');
      // 这里可以添加更多的逻辑，例如刷新游戏列表
    } catch (error) {
      alert('Error adding game');
    }
  };

  const handleDeleteGame = async (gameId) => {
    try {
      await deleteGame(gameId);
      alert('Game deleted successfully');
      // 这里可以添加更多的逻辑
    } catch (error) {
      alert('Error deleting game');
    }
  };

  return (
    <div>
      <input
        type="text"
        value={gameName}
        onChange={(e) => setGameName(e.target.value)}
        placeholder="Enter game name"
      />
      <button onClick={handleAddGame}>Add Game</button>
      {/* 这里可以添加游戏列表和删除按钮 */}
    </div>
  );
}

export default GameComponent;

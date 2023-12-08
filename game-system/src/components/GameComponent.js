import React, { useState } from 'react';
import { addGame, deleteGame } from '../services/gameService';

function GameComponent() {
  const [gameName, setGameName] = useState('');

  const handleAddGame = async () => {
    try {
      await addGame({ name: gameName });
      alert('Game added successfully');
    } catch (error) {
      alert('Error adding game');
    }
  };

  const handleDeleteGame = async (gameId) => {
    try {
      await deleteGame(gameId);
      alert('Game deleted successfully');
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
    </div>
  );
}

export default GameComponent;

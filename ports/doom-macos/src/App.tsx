import React, { useState } from 'react';
import './App.css';

function App() {
  const [gameState, setGameState] = useState('menu');

  return (
    <div className="app">
      <div className="header">
        <h1>DOOM DEMO</h1>
        <p>macOS Edition</p>
      </div>

      {gameState === 'menu' && (
        <div className="menu">
          <button onClick={() => setGameState('game')} className="btn btn-primary">
            ▶ PLAY
          </button>
          <button onClick={() => setGameState('controls')} className="btn btn-secondary">
            ⚙ CONTROLS
          </button>
          <button onClick={() => setGameState('settings')} className="btn btn-secondary">
            ⚡ SETTINGS
          </button>
        </div>
      )}

      {gameState === 'game' && (
        <div className="game-screen">
          <div className="game-area">
            <p>Game Engine</p>
            <p>Metal Rendering (macOS)</p>
          </div>
          <button onClick={() => setGameState('menu')} className="btn btn-back">
            ← BACK
          </button>
        </div>
      )}

      {gameState === 'controls' && (
        <div className="controls-screen">
          <h2>Touch Controls</h2>
          <div className="control-item">
            <h3>Keyboard</h3>
            <p>WASD - Movement</p>
            <p>Space - Jump</p>
            <p>E - Use</p>
          </div>
          <div className="control-item">
            <h3>Mouse</h3>
            <p>Left Click - Fire</p>
            <p>Scroll - Change Weapon</p>
          </div>
          <button onClick={() => setGameState('menu')} className="btn btn-back">
            ← BACK
          </button>
        </div>
      )}

      {gameState === 'settings' && (
        <div className="settings-screen">
          <h2>Settings</h2>
          <div className="setting-item">
            <label>Sound Effects</label>
            <input type="checkbox" defaultChecked />
          </div>
          <div className="setting-item">
            <label>Brightness</label>
            <input type="range" min="0" max="100" defaultValue="50" />
          </div>
          <button onClick={() => setGameState('menu')} className="btn btn-back">
            ← BACK
          </button>
        </div>
      )}
    </div>
  );
}

export default App;

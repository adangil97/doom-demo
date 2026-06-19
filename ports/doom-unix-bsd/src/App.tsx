import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [gameState, setGameState] = useState('menu');
  const [platform, setPlatform] = useState('Unix/Linux');

  useEffect(() => {
    (window as any).electron?.getPlatform().then((p: string) => {
      const platformNames: Record<string, string> = {
        'linux': 'Linux',
        'freebsd': 'FreeBSD',
        'openbsd': 'OpenBSD',
        'netbsd': 'NetBSD',
        'sunos': 'Solaris',
        'aix': 'AIX',
        'darwin': 'macOS',
      };
      setPlatform(platformNames[p] || p);
    });
  }, []);

  return (
    <div className="app">
      <div className="header">
        <h1>DOOM DEMO</h1>
        <p>Unix/BSD Edition - {platform}</p>
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
            <p>Universal Unix/BSD Rendering</p>
            <p>Platform: {platform}</p>
          </div>
          <button onClick={() => setGameState('menu')} className="btn btn-back">
            ← BACK
          </button>
        </div>
      )}

      {gameState === 'controls' && (
        <div className="controls-screen">
          <h2>Controls</h2>
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

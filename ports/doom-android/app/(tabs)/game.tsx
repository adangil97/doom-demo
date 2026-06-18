import { View, Text, TouchableOpacity, Alert } from "react-native";
import { useRouter } from "expo-router";
import { useState } from "react";

import { ScreenContainer } from "@/components/screen-container";
import { GameRenderer } from "@/components/game-renderer";
import { TouchControls } from "@/components/touch-controls";

/**
 * Game Screen - Doom Demo Game Renderer
 *
 * Esta pantalla muestra el juego Doom con renderizado OpenGL ES
 * y controles táctiles.
 */
export default function GameScreen() {
  const router = useRouter();
  const [score, setScore] = useState(0);
  const [isPaused, setIsPaused] = useState(false);

  const handleGameOver = () => {
    Alert.alert(
      "Game Over",
      `Final Score: ${score}`,
      [
        {
          text: "Return to Menu",
          onPress: () => router.back(),
        },
        {
          text: "Play Again",
          onPress: () => {
            setScore(0);
            setIsPaused(false);
          },
        },
      ]
    );
  };

  const handleScoreChange = (newScore: number) => {
    setScore(newScore);
  };

  return (
    <ScreenContainer className="p-0 bg-black">
      {/* Renderizado del juego */}
      <GameRenderer
        onGameOver={handleGameOver}
        onScoreChange={handleScoreChange}
      />

      {/* Controles táctiles */}
      <TouchControls />

      {/* Botón de pausa en la esquina superior izquierda */}
      <TouchableOpacity
        style={{
          position: "absolute",
          top: 16,
          left: 16,
          backgroundColor: "#8B0000",
          paddingHorizontal: 12,
          paddingVertical: 8,
          borderRadius: 4,
          borderWidth: 1,
          borderColor: "#FF0000",
          zIndex: 100,
        }}
        onPress={() => {
          setIsPaused(!isPaused);
          if (!isPaused) {
            Alert.alert(
              "Game Paused",
              "Press Resume to continue or Return to Menu to exit.",
              [
                {
                  text: "Resume",
                  onPress: () => setIsPaused(false),
                },
                {
                  text: "Return to Menu",
                  onPress: () => router.back(),
                },
              ]
            );
          }
        }}
      >
        <Text style={{ color: "#FFF", fontWeight: "bold", fontSize: 12 }}>
          {isPaused ? "RESUME" : "PAUSE"}
        </Text>
      </TouchableOpacity>
    </ScreenContainer>
  );
}

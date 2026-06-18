import { ScrollView, Text, View, TouchableOpacity, Image } from "react-native";
import { useRouter } from "expo-router";

import { ScreenContainer } from "@/components/screen-container";

/**
 * Home Screen - Doom Demo Main Menu
 *
 * This is the main menu for the Doom Demo Android game.
 * Players can start the game, view controls, or access settings.
 */
export default function HomeScreen() {
  const router = useRouter();

  const handlePlayGame = () => {
    // TODO: Navigate to game screen when implemented
    console.log("Play Game pressed");
  };

  const handleControls = () => {
    // TODO: Navigate to controls screen when implemented
    console.log("Controls pressed");
  };

  const handleSettings = () => {
    // TODO: Navigate to settings screen when implemented
    console.log("Settings pressed");
  };

  return (
    <ScreenContainer className="p-6 bg-black">
      <ScrollView contentContainerStyle={{ flexGrow: 1 }}>
        <View className="flex-1 gap-8 justify-center items-center">
          {/* Game Title */}
          <View className="items-center gap-4">
            <Text className="text-5xl font-bold text-red-600">DOOM</Text>
            <Text className="text-lg text-green-500 text-center font-semibold">
              Mobile Edition
            </Text>
          </View>

          {/* Main Menu Buttons */}
          <View className="w-full max-w-xs gap-4">
            {/* Play Button */}
            <TouchableOpacity
              onPress={handlePlayGame}
              className="bg-red-700 px-8 py-4 rounded-lg active:opacity-80 border-2 border-red-600"
            >
              <Text className="text-white font-bold text-center text-lg">
                PLAY GAME
              </Text>
            </TouchableOpacity>

            {/* Controls Button */}
            <TouchableOpacity
              onPress={handleControls}
              className="bg-gray-700 px-8 py-4 rounded-lg active:opacity-80 border-2 border-gray-600"
            >
              <Text className="text-white font-bold text-center text-lg">
                CONTROLS
              </Text>
            </TouchableOpacity>

            {/* Settings Button */}
            <TouchableOpacity
              onPress={handleSettings}
              className="bg-gray-700 px-8 py-4 rounded-lg active:opacity-80 border-2 border-gray-600"
            >
              <Text className="text-white font-bold text-center text-lg">
                SETTINGS
              </Text>
            </TouchableOpacity>
          </View>

          {/* Game Info */}
          <View className="w-full max-w-xs bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-semibold mb-2">
              GAME STATUS
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              A classic DOOM-style shooter ported to Android. Fight through
              hordes of enemies, collect weapons, and survive the onslaught.
            </Text>
          </View>
        </View>
      </ScrollView>
    </ScreenContainer>
  );
}

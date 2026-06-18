import { ScrollView, Text, View, TouchableOpacity, Switch } from "react-native";
import { useRouter } from "expo-router";
import { useState } from "react";

import { ScreenContainer } from "@/components/screen-container";

/**
 * Settings Screen - Game Settings
 *
 * This screen allows players to adjust game settings like difficulty,
 * volume, and sensitivity.
 */
export default function SettingsScreen() {
  const router = useRouter();
  const [soundEnabled, setSoundEnabled] = useState(true);
  const [vibrationEnabled, setVibrationEnabled] = useState(true);
  const [difficulty, setDifficulty] = useState<"easy" | "normal" | "hard">(
    "normal"
  );

  return (
    <ScreenContainer className="p-6 bg-black">
      <ScrollView contentContainerStyle={{ flexGrow: 1 }}>
        <View className="gap-6">
          {/* Header */}
          <View className="items-center gap-2 mb-4">
            <Text className="text-3xl font-bold text-green-500">
              SETTINGS
            </Text>
            <Text className="text-gray-400 text-center">
              Customize your game experience
            </Text>
          </View>

          {/* Sound Settings */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <View className="flex-row justify-between items-center mb-3">
              <Text className="text-green-500 font-bold">Sound</Text>
              <Switch
                value={soundEnabled}
                onValueChange={setSoundEnabled}
                trackColor={{ false: "#767577", true: "#81c784" }}
                thumbColor={soundEnabled ? "#4caf50" : "#f4f3f4"}
              />
            </View>
            <Text className="text-gray-400 text-sm">
              Enable or disable game sound effects and music
            </Text>
          </View>

          {/* Vibration Settings */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <View className="flex-row justify-between items-center mb-3">
              <Text className="text-green-500 font-bold">Vibration</Text>
              <Switch
                value={vibrationEnabled}
                onValueChange={setVibrationEnabled}
                trackColor={{ false: "#767577", true: "#81c784" }}
                thumbColor={vibrationEnabled ? "#4caf50" : "#f4f3f4"}
              />
            </View>
            <Text className="text-gray-400 text-sm">
              Enable or disable haptic feedback on actions
            </Text>
          </View>

          {/* Difficulty Settings */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-3">Difficulty</Text>
            <View className="gap-2">
              {(["easy", "normal", "hard"] as const).map((level) => (
                <TouchableOpacity
                  key={level}
                  onPress={() => setDifficulty(level)}
                  className={`px-4 py-2 rounded border ${
                    difficulty === level
                      ? "bg-green-700 border-green-500"
                      : "bg-gray-700 border-gray-600"
                  }`}
                >
                  <Text
                    className={
                      difficulty === level
                        ? "text-white font-bold"
                        : "text-gray-300"
                    }
                  >
                    {level.charAt(0).toUpperCase() + level.slice(1)}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          {/* Sensitivity Settings */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-3">
              Look Sensitivity
            </Text>
            <View className="flex-row items-center gap-3">
              <Text className="text-gray-400">Low</Text>
              <View className="flex-1 h-1 bg-gray-700 rounded">
                <View className="h-1 bg-green-500 rounded" style={{ width: "60%" }} />
              </View>
              <Text className="text-gray-400">High</Text>
            </View>
          </View>

          {/* Game Info */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700 mt-4">
            <Text className="text-green-500 font-bold mb-2">Game Info</Text>
            <Text className="text-gray-400 text-sm mb-2">
              Doom Demo Android v1.0.0
            </Text>
            <Text className="text-gray-500 text-xs">
              A classic DOOM-style shooter ported to Android using React Native
              and OpenGL ES.
            </Text>
          </View>

          {/* Back Button */}
          <TouchableOpacity
            onPress={() => router.back()}
            className="bg-gray-700 px-6 py-3 rounded-lg active:opacity-80 border border-gray-600 mt-6"
          >
            <Text className="text-white font-bold text-center">BACK</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </ScreenContainer>
  );
}

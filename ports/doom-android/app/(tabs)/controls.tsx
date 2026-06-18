import { ScrollView, Text, View, TouchableOpacity } from "react-native";
import { useRouter } from "expo-router";

import { ScreenContainer } from "@/components/screen-container";

/**
 * Controls Screen - Game Controls Guide
 *
 * This screen displays the touch controls and how to play the game.
 */
export default function ControlsScreen() {
  const router = useRouter();

  return (
    <ScreenContainer className="p-6 bg-black">
      <ScrollView contentContainerStyle={{ flexGrow: 1 }}>
        <View className="gap-6">
          {/* Header */}
          <View className="items-center gap-2 mb-4">
            <Text className="text-3xl font-bold text-green-500">
              CONTROLS
            </Text>
            <Text className="text-gray-400 text-center">
              Learn how to play Doom on mobile
            </Text>
          </View>

          {/* Movement Control */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-2">
              MOVEMENT - Left Joystick
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              Use the virtual joystick in the bottom-left corner to move forward,
              backward, left, and right. Swipe and drag to control movement.
            </Text>
          </View>

          {/* Look Around Control */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-2">
              LOOK AROUND - Two-Finger Swipe
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              Swipe with two fingers on the screen to look around and aim.
              Swipe up/down to look up/down, left/right to turn.
            </Text>
          </View>

          {/* Fire Control */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-2">
              FIRE - Right Button
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              Tap the large red button in the bottom-right corner to fire your
              weapon. Hold for rapid fire.
            </Text>
          </View>

          {/* Door Control */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-2">
              OPEN DOORS - E Button
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              Tap the E button in the top-right corner when facing a door to
              open it. Some doors may be locked.
            </Text>
          </View>

          {/* Pause Control */}
          <View className="bg-gray-800 rounded-lg p-4 border border-gray-700">
            <Text className="text-green-500 font-bold mb-2">
              PAUSE - Menu Button
            </Text>
            <Text className="text-gray-300 text-sm leading-relaxed">
              Tap the PAUSE button in the top-left corner to pause the game
              and return to the main menu.
            </Text>
          </View>

          {/* Tips */}
          <View className="bg-red-900 rounded-lg p-4 border border-red-700 mt-4">
            <Text className="text-red-300 font-bold mb-2">TIPS</Text>
            <Text className="text-red-200 text-sm leading-relaxed">
              • Collect health packs to restore your health{"\n"}
              • Find weapons to increase your firepower{"\n"}
              • Avoid enemy fire and use cover{"\n"}
              • Complete objectives to progress
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

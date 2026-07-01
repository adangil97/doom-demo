import Foundation
import UIKit

/**
 * DoomBridge - Puente de interfaz entre Swift y el motor de juego Doom en C
 *
 * Proporciona una interfaz segura y de alto nivel para interactuar con el motor
 * de juego Doom escrito en C, manejando conversión de tipos y memory management.
 */
public class DoomBridge: NSObject {
    // MARK: - Singleton
    public static let shared = DoomBridge()

    // MARK: - Properties
    private var isInitialized = false
    private let queue = DispatchQueue(label: "com.doom.bridge", qos: .userInitiated)
    private var gameState: GameState?

    // MARK: - Initialization
    override private init() {
        super.init()
    }

    deinit {
        cleanup()
    }

    // MARK: - Public Methods

    /**
     * Inicializa el motor de juego Doom
     *
     * - Parameter width: Ancho de la pantalla
     * - Parameter height: Alto de la pantalla
     * - Throws: DoomError si la inicialización falla
     */
    public func initialize(width: Int, height: Int) throws {
        try queue.sync {
            guard !isInitialized else {
                throw DoomError.alreadyInitialized
            }

            guard width > 0, height > 0 else {
                throw DoomError.invalidDimensions(width: width, height: height)
            }

            let result = nativeDoomInit(Int32(width), Int32(height))
            guard result == 1 else {
                throw DoomError.initializationFailed(code: Int(result))
            }

            isInitialized = true
            gameState = GameState()
            print("[DoomBridge] Engine initialized successfully with dimensions: \(width)x\(height)")
        }
    }

    /**
     * Limpia y libera recursos del motor de juego
     */
    public func cleanup() {
        queue.sync {
            guard isInitialized else { return }
            nativeDoomCleanup()
            isInitialized = false
            gameState = nil
            print("[DoomBridge] Engine cleaned up")
        }
    }

    /**
     * Actualiza el estado del juego basado en entrada del usuario
     *
     * - Parameter input: InputState con los controles presionados
     * - Throws: DoomError si el motor no está inicializado
     */
    public func update(input: InputState) throws {
        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }

            nativeDoomUpdate(
                Int32(input.w), Int32(input.a), Int32(input.s), Int32(input.d),
                Int32(input.left), Int32(input.right),
                Int32(input.space), Int32(input.e), Int32(input.tab), Int32(input.r),
                Int32(input.mouseDx)
            )
        }
    }

    /**
     * Renderiza un frame del juego
     *
     * - Throws: DoomError si el motor no está inicializado
     */
    public func render() throws {
        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }
            nativeDoomRender()
        }
    }

    /**
     * Obtiene el estado actual del juego
     *
     * - Returns: GameState con la información actual
     * - Throws: DoomError si el motor no está inicializado
     */
    public func getGameState() throws -> GameState {
        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }

            var state = GameState()
            state.hp = Int(nativeDoomGetPlayerHP())
            state.ammo = Int(nativeDoomGetPlayerAmmo())
            state.armor = Int(nativeDoomGetPlayerArmor())
            state.score = Int(nativeDoomGetPlayerScore())
            state.gameOver = nativeDoomIsGameOver() == 1
            state.level = Int(nativeDoomGetLevel())
            state.enemiesKilled = Int(nativeDoomGetEnemiesKilled())

            return state
        }
    }

    /**
     * Reinicia el juego
     *
     * - Throws: DoomError si el motor no está inicializado
     */
    public func reset() throws {
        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }
            nativeDoomReset()
            gameState = GameState()
            print("[DoomBridge] Game reset")
        }
    }

    /**
     * Establece el viewport (área de renderizado)
     *
     * - Parameter width: Ancho del viewport
     * - Parameter height: Alto del viewport
     * - Throws: DoomError si las dimensiones son inválidas
     */
    public func setViewport(width: Int, height: Int) throws {
        guard width > 0, height > 0 else {
            throw DoomError.invalidDimensions(width: width, height: height)
        }

        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }
            nativeDoomSetViewport(Int32(width), Int32(height))
        }
    }

    /**
     * Obtiene estadísticas de rendimiento
     *
     * - Returns: PerformanceStats con FPS y otras métricas
     * - Throws: DoomError si el motor no está inicializado
     */
    public func getStats() throws -> PerformanceStats {
        try queue.sync {
            guard isInitialized else {
                throw DoomError.notInitialized
            }

            return PerformanceStats(
                fps: Double(nativeDoomGetFPS()),
                drawCalls: Int(nativeDoomGetDrawCalls()),
                triangles: Int(nativeDoomGetTriangleCount())
            )
        }
    }

    /**
     * Habilita o deshabilita el modo debug
     *
     * - Parameter enabled: True para habilitar debug
     */
    public func setDebugMode(_ enabled: Bool) {
        queue.sync {
            nativeDoomSetDebug(enabled ? 1 : 0)
            print("[DoomBridge] Debug mode: \(enabled ? "enabled" : "disabled")")
        }
    }

    /**
     * Verifica si el motor está inicializado
     *
     * - Returns: True si el motor está listo para usar
     */
    public func isReady() -> Bool {
        return queue.sync { isInitialized }
    }

    // MARK: - Native C Bridge Methods

    @_silgen_name("nativeDoomInit")
    private func nativeDoomInit(_ width: Int32, _ height: Int32) -> Int32

    @_silgen_name("nativeDoomCleanup")
    private func nativeDoomCleanup()

    @_silgen_name("nativeDoomUpdate")
    private func nativeDoomUpdate(
        _ w: Int32, _ a: Int32, _ s: Int32, _ d: Int32,
        _ left: Int32, _ right: Int32,
        _ space: Int32, _ e: Int32, _ tab: Int32, _ r: Int32,
        _ mouseDx: Int32
    )

    @_silgen_name("nativeDoomRender")
    private func nativeDoomRender()

    @_silgen_name("nativeDoomReset")
    private func nativeDoomReset()

    @_silgen_name("nativeDoomGetPlayerHP")
    private func nativeDoomGetPlayerHP() -> Int32

    @_silgen_name("nativeDoomGetPlayerAmmo")
    private func nativeDoomGetPlayerAmmo() -> Int32

    @_silgen_name("nativeDoomGetPlayerArmor")
    private func nativeDoomGetPlayerArmor() -> Int32

    @_silgen_name("nativeDoomGetPlayerScore")
    private func nativeDoomGetPlayerScore() -> Int32

    @_silgen_name("nativeDoomIsGameOver")
    private func nativeDoomIsGameOver() -> Int32

    @_silgen_name("nativeDoomGetLevel")
    private func nativeDoomGetLevel() -> Int32

    @_silgen_name("nativeDoomGetEnemiesKilled")
    private func nativeDoomGetEnemiesKilled() -> Int32

    @_silgen_name("nativeDoomSetViewport")
    private func nativeDoomSetViewport(_ width: Int32, _ height: Int32)

    @_silgen_name("nativeDoomSetDebug")
    private func nativeDoomSetDebug(_ enabled: Int32)

    @_silgen_name("nativeDoomGetFPS")
    private func nativeDoomGetFPS() -> Float

    @_silgen_name("nativeDoomGetDrawCalls")
    private func nativeDoomGetDrawCalls() -> Int32

    @_silgen_name("nativeDoomGetTriangleCount")
    private func nativeDoomGetTriangleCount() -> Int32
}

// MARK: - Supporting Types

/**
 * Error types para DoomBridge
 */
public enum DoomError: Error, LocalizedError {
    case notInitialized
    case alreadyInitialized
    case invalidDimensions(width: Int, height: Int)
    case initializationFailed(code: Int)

    public var errorDescription: String? {
        switch self {
        case .notInitialized:
            return "Doom engine is not initialized"
        case .alreadyInitialized:
            return "Doom engine is already initialized"
        case .invalidDimensions(let width, let height):
            return "Invalid dimensions: width=\(width), height=\(height)"
        case .initializationFailed(let code):
            return "Initialization failed with code: \(code)"
        }
    }
}

/**
 * Estructura para el estado del juego
 */
public struct GameState {
    public var hp: Int = 0
    public var ammo: Int = 0
    public var armor: Int = 0
    public var score: Int = 0
    public var gameOver: Bool = false
    public var level: Int = 0
    public var enemiesKilled: Int = 0
}

/**
 * Estructura para entrada del usuario
 */
public struct InputState {
    public var w: Int = 0
    public var a: Int = 0
    public var s: Int = 0
    public var d: Int = 0
    public var left: Int = 0
    public var right: Int = 0
    public var space: Int = 0
    public var e: Int = 0
    public var tab: Int = 0
    public var r: Int = 0
    public var mouseDx: Int = 0

    public init() {}
}

/**
 * Estructura para estadísticas de rendimiento
 */
public struct PerformanceStats {
    public let fps: Double
    public let drawCalls: Int
    public let triangles: Int
}

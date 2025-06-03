# 🏹 Classy Arrow Game

A stylish and modular arrow shooting game developed in Java using the Processing graphics library. Built with clean object-oriented architecture and SOLID principles for clarity, flexibility, and extendability.

## 🎮 Gameplay

Control the bow, aim with the mouse, and shoot arrows to hit moving targets. The faster and more accurately you shoot, the higher your score. Each successful hit increases the game speed, challenging your reflexes and aiming skill.

## 🛠 Features

- 🎯 Target movement with difficulty scaling
- 🏹 Realistic arrow mechanics with trajectory physics
- 💥 Collision detection and scoring system
- 🧩 Modular, SOLID-compliant architecture
- 🎨 Rich visual feedback using Processing

## 🧱 Architecture Highlights

### SOLID Principles in Action:
- **S - Single Responsibility**: Each class has one clear job (e.g., `Arrow`, `Target`, `GameManager`, `UIRenderer`).
- **O - Open/Closed**: Entities like `Target` can be extended (e.g., `FastTarget`, `ZigzagTarget`) without modifying core logic.
- **L - Liskov Substitution**: Inherited objects like `MovingTarget` can be used in place of base `Target`.
- **I - Interface Segregation**: Game components implement only what they need (`Drawable`, `Updatable` interfaces).
- **D - Dependency Inversion**: High-level classes depend on abstractions (`IGameObject`, `ITargetLogic`) not on concrete implementations.

## 🗂 Project Structure

ClassyArrowGame/
├── src/
│ ├── core/ # GameManager, App entry point
│ ├── entities/ # Arrow, Bow, Target
│ ├── interfaces/ # Drawable, Updatable, Collidable
│ ├── mechanics/ # Physics, CollisionDetector
│ └── ui/ # ScoreBoard, UI Renderer
├── assets/ # Images, sounds
└── README.md

markdown
Copy
Edit

## 🚀 Getting Started

### Requirements
- Java 11+
- [Processing 4+](https://processing.org/download/)
- IDE (e.g., IntelliJ IDEA, Eclipse)

### Run the Game
1. Clone the repo:
   ```bash
   git clone https://github.com/ZEY0D/Archery-Rush-Game.git
   cd classy-arrow-game
Open in your favorite Java IDE.

Run MainApp.java from the core package.

🎉 You're ready to play!

🔧 Customization
Want to add fire arrows? Zigzag targets? Powerups? Extend the base classes in entities or create new TargetBehavior strategies without touching existing code. The architecture is designed for easy feature integration.

🤝 Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to change or add.

📄 License
MIT License

Developed with ❤️ using Java + Processing.

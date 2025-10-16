## Core Video SDK Roku coding challenge.

What is required?

1. Add different artwork to assets in Assets.brs.
2. Extend the player API with **PAUSE** / **RESUME** / **FAST FORWARD**/ **REWIND** / **BACK** functionality.
    * **FAST FORWARD** / **REWIND** should add/subtract 10 seconds to the current position.
    * **BACK** should exit the player.
3. Create a logger with configurable output: log to console by default, log to the screen via extension.
    * log video state changes.
    * log errors.
4. Unit Test new functionality.

How to get started.

1. Checkout this project (or unzip files from .zip).
2. Make sure npm is installed with: `brew install npm`
3. Install yarn and gulp 
    * `npm install -g yarn gulp` - *This installs yarn and gulp as global terminal commands.*
4. Run `yarn` - *Make sure you run this one from the project root directory.*
5. Run `gulp` - *To produce deployable package. It will be created in 'out' folder.*
6. Run `gulp test` - *To produce a package with unit tests.*

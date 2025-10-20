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

1. Check out this project (or unzip files from .zip).
2. Make sure npm is installed with: `brew install npm`
3. Install yarn and gulp 
    * `npm install -g yarn gulp` - *This installs yarn and gulp as global terminal commands.*
4. Run `yarn` - *Make sure you run this one from the project root directory.*
5. Run `gulp` - *To produce a deployable package. It will be created in the 'out' folder.*
6. Run `gulp test` - *To produce a package with unit tests.*



### **Roku Channel Instructions**

**Configuration:**

To change the configuration of the logger, open:
`source/main.brs` and locate **line 11**.
You can modify the parameters in the following block:

```brightscript
params = {
    disableLogging: false ' Enable or disable debugging logs
    logLevel: LogLevel().TRACE ' There are 6 levels; TRACE is the most verbose
    name: "Default" ' The name of this logger (you can define multiple)
    disableLoggingToScreen: false ' By default, logging output is shown on the screen
}
```

---

**Using the Channel:**

* **Play / Pause:**
  Toggle the **Pause/Play** button to pause or resume the video.

* **Fast Forward:**
  Press the **Fast Forward** button to advance playback.
  The video will pause during fast-forwarding. Press again to resume playback.

* **Rewind:**
  Press the **Rewind** button to reverse playback.
  The video will pause during rewinding. Press again to resume playback.

* **On-Screen Logging:**

  * Logs are displayed with the **newest entries at the top**.
  * Press the **Config** button to **enable or disable** on-screen logging.
  * Press the **Info** button to **display control instructions** in the on-screen logging area.

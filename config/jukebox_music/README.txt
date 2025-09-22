The enclosed /sounds folder holds the sound files used for player selectable songs for an ingame jukebox. OGG and WAV are supported.

Using unnecessarily huge sounds can cause client side lag and should be avoided.

You may add as many sounds as you would like.

---

Naming Conventions:

Every sound you add must have a unique name. Avoid using the plus sign "+" and the period "." in names, as these are used internally to classify sounds.

Sound names must be in the format of [song name]+[length in deciseconds]+[beats per minute].ogg

BPM IS REQUIRED, BUT VALUE IS OPTIONAL, meant for light-syncing. Put "60" as placeholder if that isn't important.

A three minute song title "SS13" that lasted 3 minutes would have a file name SS13+1800+60.ogg

Songs must be inside config/jukebox_music/sounds to be loaded

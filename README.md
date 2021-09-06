Weather Application is the implementation of MVP design pattern and free a avalaible API ( https://www.metaweather.com/api/ ) written in Swift language with xCode IDE. 

Some of the basic functionality of the app are: 
 -   It is available for the user to get coordinates for closest cities locations, to choose
-  It is available for the user to persisted he's current city into CoreData
- Shows the weather forecast on daily and weekly (7 days back) level. 

It’s important to note that MVP uses passive View pattern. It means all the actions will be forwarded to the presenter. Which will trigger the ui updates using delegates. so the view will only passe actions and listen to the presenter updates.

Worked on: 
- Milos Drljaca ( https://github.com/MilosDrljaca )
- Aleksandar Aleksic ( https://github.com/1aleksandaraleksic )

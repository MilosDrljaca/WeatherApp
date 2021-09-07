<h1>Weather Application</h1>
Weather Application is the implementation of <b>MVP</b> <i>design pattern</i> and free available API ( https://www.metaweather.com/api/ ). It is written in <b>Swift</b> programming language with <b>xCode</b> IDE on <b>iOS</b> <i>operating system</i>.<br/>
<br/>
Some of the functionality of the app are:
<ul><li>User can get coordinates for closest cities locations
<li>Current city will be stored into mobile memory by <b>CoreData</b>
<li>User can get the weather forecast for <b>daily</b> and <b>weekly</b> schedule.
</ul>
As was written above the application was developed in Model View Presenter (MVP) design pattern, this pattern separates the objects into three main components: <i>Model</i>, <i>View</i>, and <i>Presenter</i>. It’s important to note that  <b>MVP</b>  uses a <i>passive View pattern</i>. It means all the actions will be forwarded to the <b>presenter</b>, which will trigger the <i>UI updates</i> using delegates so the view will only pass actions and listen to the presenter updates.<br/>
<br/>
Authors:<br/>
- Aleksandar Aleksic ( https://github.com/1aleksandaraleksic )<br/>
- Milos Drljaca ( https://github.com/MilosDrljaca )

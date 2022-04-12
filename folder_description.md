## Folder Descriptions
To a beginner, it might seem absurd or useless to bifurcate a flutter application into so many portions, 
but if maintaining a good file structure becomes a habit it could be many benefits.
And for big organizations working on production applications, maintaining a good file structure is not an option it’s a necessity.

Folders:-

### assets(Assets:  Static assets for the app)
```
This directory is on the root level, it will contain all the static assets that are used in the application, 
for example, fonts, icons, logos, background images, demo videos, etc.
It is very much recommended that we should have different directories for a different type of data for example 
images, videos & logos, should have a different folder of their own so that it becomes easier to maintain and access them.
```

### lib/screens(Screens: Screen /UI of the app)
```
This directory will contain the actual layout of the UI for the entire application. 
It can further be distributed into multiple folders. One which stored the flash screen and onboarding pages such as login/sign-up screen, 
the other folders can store the home screen and other generally used screens.
```

### lib/provider(Providers: Interactions outside the app)
```
This directory is supposed to hold all the interactions that transact the data from outside the app.
This is different from the cloud functions, in regards to that none of the code in this directory will interact will cloud storage or server.
If we take into consideration a weather app, a good example would be the weather and the location data that is received from the API in the form of JSON that needs to be translated for use.
```

### lib/utils(Utilities: Function or logic used in the app)
```
This directory will hold all the app logic or business logic of our entire application.
Again a good example in the weather app would be when a user selects a different location the weather data should also change accordingly.
Or in the case of the social media app when logins the app data should also change accordingly.
```

### lib/widgets(Widgets: Widgets / Layouts used in the app)
```
It becomes clear all by the name itself that this folder will hold all the static widgets or the widgets that are used multiple times in the application. 
For example, if it is a social media app like Instagram, the list view of all the suggested friends is always the same, the only thing that changes in the data. 
Or if it is a weather app the tile which shows a particular location is the same for all the location, the only thing that change is the name of the place.
```

### lib/models(Models: Collection of data)
```
Models are the collection of data that are usually sourced from the servers, users, or external APIs, 
these are used in combination with widgets to complete the user interface of the app. 
Again, taking an example of the weather app a model or a set of data could be the name of the location, temperature in both Celsius and Fahrenheit. 
If we take into consideration a social media app that is showing a user’s profile page then it may contain the username, age, a profile pic, a description, etc.
```
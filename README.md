# Welcome to "To-Do Lift"
Where you can view, load, and save workouts in a lightweight application. 



## Features

WorkoutList.swift
- view and checkmark lifts in the to-do list view
- add another lift to your current workout at the top of the page
- delete lifts from the current workout by swiping on the workout
- delete all lifts from workout by clicking the 'clear' button
- add current workout to your workoutHistory via the 'Complete workout' button
- add weight and edit other details in the lift by swiping and selecting 'more'

workoutLoader.swift
- create workout templates that easily populate in your to-do list via the "+" icon at the top right corner of the screen
- populate to-do list with a saved workout template via the "+" icon next to the workout name
- delete workout templates by selecting the "-" icon in the top left corner, tapping this again will disable this option

workoutHistory.swift
- View a list of completed workouts here
- click to exapand the workout to see all movements, sets, reps, and weights completed
- delete past workouts by swiping and tapping 'delete'

## Code layout

[WorkoutTemplate.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Models/WorkoutTemplate.swift) - contains the objects used throuhgout program
```swift
struct Movement: Hashable, Codable {
    var name : String
    var sets: String
    var reps: String
    var weight: String
    
struct WorkoutTemplate: Hashable, Codable{
    var name : String
    var movements: [Movement]
}
```
These two objects are the backbone of the code. Without workout template containing a name and a list of Movements. 
An example of a wokroutTemplate be having name refer to "chest day" and the list of movement be any movments that you incorperate in your chest day (IE: [Bench Press, 3, 3, 135])

[dataManager.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Models/dataManager.swift) - holds all save and load functions for "movementList", "WorkoutList", and pastWorkouts"

[Contentview.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/ContentView.swift) - Project Main
Main view of program uses a tabview to connect workoutList.swift, workoutLoader.swift, and workoutHistory.swift

[WorkoutList.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/WorkoutList.swift) - To-Do list view
View that presents list of movements named "movementsList" in a to-do list like format. 
Inside the list, we can:
- check movements as complete
- delete movements from list with swipe
- access the moreInfoView with swipe

[moreInfoView.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/moreInfoView.swift) - more info for movements in workoutList.swift
moreInfoView is a supporting view to the workoutList.swift. In this view, we give the user the ability to
add weight used on their movement as well as the ability to edit the existing movement object.

[workoutLoader.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/workoutLoader.swift) - where we can load workout tempates to to-do list
WorkoutLoader is a support element to workoutList. This file uses the workoutTemplate object that is located
in workoutTemplate.swift. In this file we present the user with the sotred list of workouTemplates named "workoutList"
 
In additon, we can delete workoutTemplates and have a navigtion link to the newWorkoutView.swift where we can
add a new workoutTemplate object to our list "workoutList"

[newWorkoutView.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/newWorkoutView.swift) - for adding workouts to workoutList
newWoroutView is a pop up screen that is accessed from workoutLoader. This screen allows user to create a
new workoutTemplate object and add it to the workoutList.

[workoutHistory.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/workoutHistory.swift) - shows completed workouts
workoutHistory takes our completed workout from workoutList.swift and presents it with the day completed
for user to reference later

## Privacy Polocy
We don't collect any data... but here is the link:
https://www.privacypolicies.com/live/10420de1-a183-40cf-b48b-b7a31fd3a81e

## Contact info
Email: jblanco0110@gmail.com  
For all emails, please put "ToDoLift" in subject line to get to the corrent inbox

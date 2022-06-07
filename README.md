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




[Contentview.swift](https://github.com/JaredBlanco6/WorkoutList/blob/main/WorkoutList/Views/ContentView.swift) - Project Main
In this view, 


## Contact info
Email: jblanco0110@gmail.com
For all emails, please put "ToDoLift" in subject line to get to the corrent inbox

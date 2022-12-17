# Thirdwayv

_ Design patterns used:
1-Observer: 
  1. Used it in network minotoring to get notified of the network connection changes.
  2. Bind the data in the viewmodel to the viewcontroller and update the UI accordingly.
------------
2- Singleton Pattern:
  1. Used in UserDefaults manager.
  2. Used in the network monitoring class.
-----------------------------------------------------------------------------------------

_ Architecture pattern used is MVVM :
1- Cleaner and smaller viewcontroller with the logic moved to the viewmodel.
2- ViewModel never knows what the view is or what the view does which makes Better Separation of Concerns.
3- Testing view models is easy. Because a view model doesn’t have a reference to the object it is owned by, it easy to write unit tests for a view model.

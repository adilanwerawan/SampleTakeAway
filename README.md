# SampleTakeAway
Sample test app for TakeAway.com, Unit tests and UITests are also written, Restaurants json is loading from local.

**About The Project**

Sample test app for TakeAway.com, Unit tests and UITests are also written, Restaurants json is loading from local.

**It uses :**

•    Swift 4.2

•    Autolayouts

•    Pods

•    Storyboards

•    MVVM


**Branches :**

•    Master

**Features :**

**Master Branch**

•    RestaurantListingVC is the main view controller with listing of restaurants loading from local json file

•    Filter the resaurant by its name, Different sort options available.

•    Unit tests includes

•    Alamofire used for api parsing (Json file loaded from local)

•    MVVM used as base architecture

•    Cocoa pods has been used for dependency management

**Testing the app:**

To run the app do following steps

•    Go to SampleTakeAway/SampleTakeAway 

•    Open SampleTakeAway.xcworkspace

•    And then you can run by pressing on run button in xcode to your favorite simulator or device

To run the unit & ui tests do following steps

•    Go to product then press test or you can do it by pressing command + u

•    It will run all the test cases which you can see in Test navigator in Navigator window (at right side of xcode)

To see the **code coverage** there is default xcode navigator named Report navigator in which you can see the code coverage.


**Folder Structure :**

**You can find..**

•    All the view controllers inside the Controllers folder.

•    All the models inside the Model folder.

•    Api managers inside the ViewModel folder.

•    Api wrapper,api endpoints inside the Networking folder

•    All the extenions like UITextfieldExtenion,StringExtension etc inside the Utilities/Extensions folder.

•    Alamofire used for http networking

•    Utilities like Alerts, DeviceUtility to get device type and sizes, AppStoryboardAndNavigation class for setting and loading viewcontrollers from thier storyboards and other utilities inside the Utilities folder.

•    Custom views created if any then it would be in Custom folder.

•    Pods used for managing third party libraries.

**Funtionality and implmentations:** 

**Networking and api usage**

•    For apis and networking we are using Alamofire

•    We have created wrapper using Alamofire named AFWrapper.

•    Api end points should be defined in ApiEndPoints class.

•    For using or implmenting the apis. Follow the steps below :

**Third party libraries management using Pods**

•    We have setuped also this project for using pods.

•    Any third party library for CocoaControls or CocoaPods you can add using pods. Simple add pod of the lib like we added for Alamofire and install it using terminal.


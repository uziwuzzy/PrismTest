# PrismTest
a test of ios development
    
    xcode 9.2 swift 4
    To run this app, go to folder, and do pod install. Then open xcworkspace.

The thought process of building this app contains 2 phase: the brainstorming phase and execution phase. Firstly, I try to breakdown the steps and problems:
I am not using full MVC because the data I used is only "message", so I put the model in the controller. However, the view is located seperatly.
1. Brainstorming phase:
    1. Brainstorming the User Interface(choosing Slack as inspiration)
        - plan to use storyboard for rapid prototyping
        - plan to use IBDesignable for gradient design
        - plan to use harmburger menu library
    2. Brainstorming the main goal(Core problems)
        - planning how to get data from url using networking (alamofire comes as first option)
        - planning how to make the desired Chatcell, if message data contains url, show preview:
            1. search for keyword: url Preview, link preview in chat etc.
            2. finally found library called swiftLinkPreview and urlEmbeddedPreview
            3. try both the demo example
            4. decide to use urlEmbeddedPreview because easier
            5. search how to detect url in string, found this [link](https://www.hackingwithswift.com/example-code/strings/how-to-detect-a-url-in-a-string-using-nsdatadetector)
2. Execution Phase
    1. The UI execution, goal: create dummy UI (not fully functional)
        - search asset for hamburgerMenu, and button
        - build a plain storyborad
        - use IBDesignable for gradient design
        - use SWRevealViewController to enable hamburgerMenur
        - create dummy textfield with send button icon
    2. Main Goal (Core problems) execution, goal: get data, adjust cell height if contains url and show url preview if exist.
        - use cocoapods to install library
        - use alamofire for networking, try to get data and show it on cell
        - implement how to detect if string contains url [link](https://www.hackingwithswift.com/example-code/strings/how-to-detect-a-url-in-a-string-using-nsdatadetector)
        - use urlEmbeddedView in containerView to show url
        - hide containerView when message has no url
        - cell height and bubble can't be adjusted, find the solution to use section instead of cell [link](https://stackoverflow.com/questions/6216839/how-to-add-spacing-between-uitableviewcell)
        - adjust rowHeight depending if messageData contains url or not
        - code clean up, seperate the view code for Chat Cell.
        - add comment as documentation of code


Case study sample iOS app that generates a dynamic form according to an api request response.

Usually when it comes to lists in UIKit the answer is to use a tableView. It's a very powerful tool. You have many options and can easily use the built in complex features like reusing cells. It turns out that in some very rare cases tableView is not the best approach though. Dynamic forms is one of them. I usually use stack views combined with a scroll view when I don't want the reusable aspect and know (or atleast have an idea) of how many cells there are. It is still possible to implement this project using a tableView, in fact I have done it myself. If you want to check it out just go back few commits. That being said it's a great exercise to compare the two and understand how in this case using a stackView simplified everything and made the code more reusable. If you desagree or have any comments at all about the subject I would love to hear it. This project was done purely for learning purposes.

## Gif:
![](https://media.giphy.com/media/6g5ktcc4Jl2A2TusYS/giphy.gif)

## Technologies used:
### Design patters:
  - Composer
  - Builder
  - Observer
  - Delegation

### Arquitecture used:
  - MVVM-C
  
### Others:
  - Error Handling
  - Auto-Layout
  - UIKit (stack + scroll views)
  - View Code (programmatic view)
  - Threads
  - Animation
  - Extensions
  - Api request (protocol + generic)
  - Loading screen
  - Unit test (async code)
  - GitFlow

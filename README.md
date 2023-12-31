# RestaurantRNG

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Updated Course Portal group info: Group Name + App Description](#Updated-Course-Portal-group-info)
4. [Initial Brainstorming Ideas](#Initial-Brainstorming-Ideas)
5. [Evaluation of Top 3 Ideas](#Evaluation-of-Top-3-Ideas)
6. [Final App Idea Chosen](#Final-app-idea-chosen)
7. [Wireframe Images](#Wireframes)
8. [Schema](#Schema)

## Overview
### Description
RestaurantRNG is designed to remove the stress involved when deciding what to eat. No longer will users have to spend hours deciding where their next meal will come from.  Just press a button and RestaurantRNG will tell you what restaurant to feast at.

## Updated Course Portal group info:
1.Group Name: TheBestThatEverLived
2. App Description and Final App Idea Chosen:
Our final app idea is an application that allows indecisive users to have a way of picking food places to eat at a selected price tag. This will be done by having the user click a button that will randomly select a restaurant and allow the user to either accept or reroll the restaurant they are given. 

## Initial Brainstorming Ideas: 
1. Poker game
2. Food Chooser app
3. Travel Application
4. Finance Application

## Evaluation of Top 3 Ideas:
1. Poker game a game that you can play with other people
2. Food app that helps indecisive people find places to eat
3. Travel Application to help people find good travel spots

## Final app idea chosen:
1. RestaurantRNG a food app that helps indecisive people find a place to eat with the press of a single button.

### App Evaluation
- **Category:** Dining/Restauraunt Application
- **Mobile:** This app would be primarily developed for mobile but would perhaps be just as viable on a computer, such as tinder or other similar apps. Functionality wouldn't be limited to mobile devices, however mobile version could potentially have more features.
- **Story:** Obtains the user location and displays **N** amount of restaurant available within the selected distance radius and rating.
- **Market:** Target indecisive people who have trouble being able to pick a place to eat.
- **Habit:** This app can be used anytime the user needs help deciding where to enjoy their next meal.
- **Scope:** First we will target a single user experience, displaying non persistent restaurant options.  The application could evolve to include user authentication and profile to store dining preferences, favorited restaurants and history of visited restaurants.  Furthermore, the applicaiton can also be used by the single user to share the selected restaurant.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* As the user I should be able to see my  location on the map.
* As the user I should be able to see the nearby restaurants.
* As the user I should be able to have a random restaurant selected for me.
* As the user I should be able to view the details of the restaurant I selected.
* As the user, I should be able to see the price in terms of dollar signs of the restaurant available.
* As the user I want to accept or reroll the restaurant that was selected.
* As the user I want to go back to the map view.
* As the user I want to be able to share the restaurant that was picked.

**Optional Nice-to-have Stories**
* As the user I should be able to create a user account.
* As the user I can login and logout of my account
* As the user I can narrow the random restaurant generator to only specify a type of food I wish to select
* As the user I can choose randomly from my favorite restaurants
* As the user I should have a graphic representation of RND selection of restaurants(wheel, dice...).

### 2. Screen Archetypes

* Restaurant Map Screen
   * As the user I should be able to see my  location on the map.
   * As the user I should be able to see the nearby restaurants.
   * As the user I should be able to have a random restaurant selection.
* Restaurant Detail VC
   * As the user I should be able to view the details of the restaurant I selected.
   * As the user I want to accept or reroll the restaurant that was selected.
   * As the user I want to go back to the map view.
   * As the user I want to be able to share the restaurant that was picked.

### 3. Navigation

**Flow Navigation** (Screen to Screen)

* Restaurant Map Screen
   * When the user loads the application it will show the map containing the restaurants nearby. This screen contains the button for generating random restaurants.  
* Restaurant Detail Screen
   * Tapping the annotation sends the user over to the restaurant detail screen. This screen contains the information for the restaurant and the option to accept and reroll for a new restaurant.

## Wireframes
<img src="https://i.postimg.cc/TPjMY5hn/wireframe.jpg" width=600>

## MVP Walkthrough
<img src ="https://github.com/CodePath-Capstone-TheBestThatEverLived/RestaurantRNG/blob/main/RestaurantRNG/RestaurantRNG/Assets.xcassets/demoMVP.dataset/demoMVP.gif?raw=true">

### Models
* User
* Restaurant
* Favorites
* Cuisine

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

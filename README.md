<h1 align="center" xmlns="http://www.w3.org/1999/html">
  <br>
   <img src="https://user-images.githubusercontent.com/64373963/158184057-2a3e2f03-9e40-4af3-8334-edb11ca5c85a.png" width=520 height=240 />
  <br>
</h1>


<p align="center">
  <img src="https://img.shields.io/github/repo-size/Shantanu66/CardAccumulator?color=purple">
  <img src="https://img.shields.io/github/stars/Shantanu66/CardAccumulator?color=%23&logo=flutter">
  <img src="https://img.shields.io/npm/v/node?color=%23ff0000&logo=Node.js">
  <img src="https://img.shields.io/maintenance/no/2022">
  <img src="https://img.shields.io/github/commit-activity/y/Shantanu66/CardAccumulator?color=%23ff3&logo=commit">
  <img alt="GitHub" src="https://img.shields.io/github/license/Shantanu66/CardAccumulator?color=cyan">
</p>

# CardAccumulator:

How pleasent it would be if you could store all your necessary cards in one simple app ! Amazing right?

I propose a `Fullstack android(You can  build it for IOS too) application` where a person or a group of people(like families,relatives,etc) can store all their government authentication ID's(Aadhar,PAN,Driving License,etc) and their transactional banking cards(credit/debit card) all together in a common place.
This App is built using `Flutter` for the client side development
For the sever side development i used `NodeJs`,`ExpressJs` and the API is built using `GraphQL` which results in minimized data usage due to fewer requests
For the remote database i used a nosql db-`MongoDB`
The Holder can save all the details of the cards and the card number is well encrypted using symmtric cyptography algorithm using the `block cipher technique` with an appealing UI design.
Also performed automation unit-testing of the graphAPI using `jest` and `supertest`.Automated the `CI/CD pipeline` using `CircleCI` deploying it to `heroku` and also `dockerized` the app.
# What is the need of addding CI/CD to the app
> As you know its very crucial to build and test you code before pushing it to production so every change you make might impact your `code quality` and the most important point is that we are using a backend/API which might need `code revisions` and has to be deployed over the www so it becomes a hassle to code-check every now and then after making some revisions and also you have to deploy it each time so it makes it quite inconvinient for the developer.So automating these processes really would help the developer to solely focus on the development part.
# How To Run This Project

    Clone the repository.
    cd card_accumulator
    Do flutter pub get.

# Preview
![combine_images](https://user-images.githubusercontent.com/64373963/158635341-64d23acf-9f95-45dd-af95-ac97056f6e44.png)
# Features

- [x] Facilitates users to store their <strong>personal cards</strong>,modify them and delete them without having to refresh.<br/>
- [x] Powered by the single threaded non blocking event driven architecture of nodejs, it can handle millions of concurrent connections with ease. 
- [x] Uses the leading open source NoSQL database mongoDB.<br />
- [x] Efficient encryption of card number for enhanced privacy <br />
- [x] Minimized data usage and highly robust<br />
- [x] highly scalable server able to handle multiple requests at once<br />
- [x] Fluid and Interactive user interface<br />

# Three-Tier System Architecture
![Card Accumulator drawio](https://user-images.githubusercontent.com/64373963/187998385-462b9f1b-ff40-4cf3-9455-ddd796005ae9.png)


# Working Demo:
<p align="center">
  
   <img src="https://user-images.githubusercontent.com/64373963/183901214-f366aa06-02e8-4660-9b84-5e5adf7800ed.gif">
  
</p>


# Steps to download

Now you can clone the repo and test it out if you find any bugs or if you can add any desirable improvements please contribute to it.
Thanks
PS : SDK will be available soon

# PS:

Was showcased as one of the best projects in Google devfest 2021.

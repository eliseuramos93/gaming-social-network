# Gaming Social Network

This project creates a social network app for gamers to track the games they played, their impressions about the games, and share its lists and reviews with friends and followers.

## Motivation for this project
This is my first solo project after a series of courses on how to develop using frameworks such as Ruby on Rails, Sinatra, VueJS, and development practices such as Test-Driven Development and Feature Branch. This is a studying/portfolio project from a person that started in the world of web development in June/2023, so don't expect deep advanced stuff, but I'm sure you'll like what will come out of this project :)

## Pre-requisites to run the aplication
All you need is to have Docker set up in your machine, since every single part of the aplication is run in an individual container (one container for the Rails application, one for the PostgreSQL database, etc).

If you don't have Docker set up on your local machine, please visit the Docker website and follow the instructions to set up your local environment accordingly to your OS.

## Project's dependencies
- **Ruby version**: 3.3.0 (executed in a Docker container w/ Google Chrome installed on it for tests)
- **Rails version**: 7.1.3.2
- **Puma version**: 5.0
- **PostgreSQL version**: 16.2 (executed in a Docker container)
- **Docker version**: 25.0.4
- **Testing framework:** RSpec
    - Capybara is used for system tests;
    - SimpleCov is used for tracking tests coverage;
    - Rubocop is used for code style/lint checking;
    - Debug is used for debugging the application;

## About languages in the project
This project starts having the application content, commit and pull request messages in Brazilian Portuguese (pt-BR), while the README and the code will be in English (just to show I can communicate in English, it being a big deal for devs and stuff...). Along the way, probably I'll create more versions of this README in different languages (and maybe add an I18n so the app can also be in English), but keep in mind I'll favor Brazilian Portuguese over another languages to speed up my workflow. 

## How to run the application

First of all, you'll need to clone the project's repository in your local machine. You can do this by running this command in a Unix-like shell:

```bash
git clone git@github.com:eliseuramos93/gaming-social-network.git
```

After that, with a Docker installation set up on your local machine, all you need is to run the following command on the project's root directory:

```bash
docker compose up --build
```

Then, you'll need to set up the Rails application to properly initiate the database, install all dependencies, etc. You can do this by running this command at the project's root directory on your shell:

```bash
docker compose run rails bin/setup
```

If you already have created the Docker containers and volumes before, you can save some time when running the compose again by adding a `--no-recreate` option in your command, like this:

```bash
docker compose up --build --no-recreate
```

## Thank you and Dedications
Thanks to all my peers during the TreinaDev course, especially the ones that worked side-by-side with me in the [Portfoliorrr](https://github.com/TreinaDev/td11-portfoliorrr) project. If you're looking for some awesome junior Ruby on Rails devs from Brazil, you'll find a lot of them there!

This project is dedicated to Adrissia, who stood by my side during my entire career transition from Customer Experience to Web Development. Even in the hardest of times, you always found a way to keep my spirits up when I needed the most. If I'm able to pull this off now, it's thanks to you helping me along the way. 🖤
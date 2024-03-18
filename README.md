# Gaming Social Network

This project creates a social network app for gamers to track the games they've played, their impressions about the games, and share their lists and reviews with friends and followers.

## Motivation for this project
This is my first solo project after completing a series of courses on how to develop using frameworks such as Ruby on Rails, Sinatra, VueJS, and development practices such as Test-Driven Development and Feature Branching. This is a study/portfolio project from someone who entered the world of web development in June 2023, so don't expect advanced stuff, but I'm sure you'll like what comes out of this project :)

## Prerequisites to run the application
All you need is to have Docker set up on your machine since every part of the application runs in an individual container (one container for the Rails application, one for the PostgreSQL database, etc).

If you don't have Docker set up on your local machine, please visit the Docker website and follow the instructions to set up your local environment according to your OS.

## Project's dependencies
- **Ruby version**: 3.3.0 (executed in a Docker container with Google Chrome installed for tests)
- **Rails version**: 7.1.3.2
- **Puma version**: 5.0
- **PostgreSQL version**: 16.2 (executed in a Docker container)
- **Docker version**: 25.0.4
- **Testing framework**: RSpec
    - Capybara is used for system tests;
    - SimpleCov is used for tracking test coverage;
    - Rubocop is used for code style/lint checking;
    - Debug is used for debugging the application;

## About languages in the project
This project starts with application content, commit and pull request messages in Brazilian Portuguese (pt-BR), while the README and the code will be in English (just to show I can communicate in English, which is a big deal for devs and stuff...). Along the way, I'll probably create more versions of this README in different languages (and maybe add an I18n so the app can also be in English), but keep in mind I'll favor Brazilian Portuguese over other languages to speed up my workflow.

## How to run the application

First of all, you'll need to clone the project's repository to your local machine. You can do this by running this command in a Unix-like shell:

```bash
git clone git@github.com:eliseuramos93/gaming-social-network.git
```

After that, with Docker installed on your local machine, all you need to do is run the following command in the project's root directory:

```bash
docker compose up --build
```

Then, you'll need to set up the Rails application to properly initialize the database, install all dependencies, etc. You can do this by running this command at the project's root directory in your shell:

```bash
docker compose run rails bin/setup
```

If you've already created the Docker containers and volumes before, you can save some time when running the compose again by adding a `--no-recreate` option to your command, like this:

```bash
docker compose up --build --no-recreate
```

## Thank you and Dedications
Thanks to all my peers during the TreinaDev course, especially those who worked side-by-side with me on the [Portfoliorrr](https://github.com/TreinaDev/td11-portfoliorrr) project. If you're looking for some awesome junior Ruby on Rails devs from Brazil, you'll find a lot of them there!

This project is dedicated to Adrissia, who stood by my side throughout my entire career transition from Customer Experience to Web Development. Even in the hardest of times, you always found a way to keep my spirits up when I needed it the most. If I'm able to pull this off now, it's thanks to you helping me along the way. 🖤

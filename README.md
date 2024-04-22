# Just Eat App

## Overview
This is a project done for Just Eat Takeaway take home assignment during Early Careers - Software Developer interview process. The app allows users to search for area postal codes in UK and returns 10 restarants in the region with certain infomation about the restaurants, including their location on the map. The app is powered by the given API of JUSTEAT takeaway.com and the output is displayed via a web interface built using Ruby on Rails.

## Installation
Follow these steps to install and run the application locally:

### Prerequisites
Before running the application, ensure you have the following software installed on your machine:
- **Ruby**: Version 3.0.0 or higher
   - Installation instructions can be found [here](https://www.ruby-lang.org/en/documentation/installation/).
- **Rails**: Version 7.0.0 or higher
   - Installation instructions can be found [here](https://rubyonrails.org/).
- **PostgreSQL**
- Installation instructions can be foun [here](https://www.postgresql.org/) or you can install by following the commands below
  - Run the following commands:
    ```bash
    brew install postgresql@15 libpq
    brew link --force libpq
    ```

    ```bash
    brew services start postgresql@15
    ```

### Instructions
1. Clone the repository:
   ```
   git clone https://github.com/karanse/just-eat.git
   ```
2. Navigate to the project directory:
  ```
  cd your-project-directory
  ```
3. Install dependencies
  ```
  bundle install
  ```
4. Set up database
  ```
  rails db:create
  rails db:migrate
  rails db:seed
  ```
5. Start the Rails server
  ```
  rails server
  ```
6. Open your web browser and navigate to`http://localhost:3000` to view the application.

## Usage
- The app is also **running on Production, deployed on Heroku**, you can check it out [here](https://justeat-27a1c970ee01.herokuapp.com/)
- The app includes seed data from given UK area postal codes, but you can search **any valid area postal code in UK** and it'll display the first 10 restaurants provided by the API. You can click on the markers on the map to  see restaurant details.


## Assumptions and Clarifications
- There is no specific assumption made for this project as the API was working fine as expected.


## Potential Improvements
- Code organization can be improved maintainability and readability.
- Implement basic error handling to provide informative error messages to users when something goes wrong.
- Improve the UI with better styling and additional features to improve usability.
- Improve accessibility features to ensure that the application is accessible to users with disabilities by adding alt attributes to images, using semantic HTML elements, and testing with screen readers. Check for color contrast and keyboard navigation.
- Implement basic tests for the  application using Rails' built-in testing framework (e.g., MiniTest or RSpec) by beginning with simple unit tests for your models and controllers to verify basic functionality.
- Develop a Show Page to display additional data for each restaurant, which can be linked via restaurant card or markers on the map.


Rails app generated with [Ruby on Rails](https://rubyonrails.org/), created by the [karanse](https://github.com/karanse).

# Little Esty Shop
[Project Board](https://github.com/users/dani-wilson/projects/1/views/1)</br>

## Project Overview
*"Little Esty Shop"* is a fictitious e-commerce platform we designed as a group project to empower merchants with advanced features for managing their items and fullfilling customer invoices. Admin users have the authority to oversee the entire system and enable or disable merchant accounts, while merchants can handle enabling and disabling products, updating statuses for items on an invoice and updating the status of invoices. The project also integrates with the Unsplash API to enhance the user experience by displaying relevant images throughout the site.

---
### Languages, Frameworks, and Tools used:
- **Building:** Ruby, Rails, HTML, CSS, and some SQL
- **Testing:** RSpec, Capybara, ShouldaMatchers
- **Database** PostgreSQL
- **Queries:** Postico, Rails Console, Rails Database Console
- **Consuming API:** HTTParty HTTP client library and Figaro to secure API keys

### Project Challenges:
- Starting this project I was most nervous about the ActiveRecord Queries and implementing the Unplash API. While extremely difficult to accomplish, working through these challenges is where I learned the most during this project. So in retrospect, the concerns were valid but it's important to keep the perspective that the biggest challenges are most likely to produce growth.
- In order to solve displaying the *Merchant's 5 Most Popular Items* on each unique merchant's dashboard, I started with bigger picture queries and slowly refined them to filter what was needed, while leveraging postico to visualize these. Ultimately it ended up being along the lines of:
  - Combining all necessary tables through associations (Merchants, Items, Invoices, Invoice Items, and Transactions)
  - Drawing new associations where possible (Merchants has many Invoices through Items)
  - Finding all merchant's invoices that qualify by having at least 1 successful transaction result
  - Then selecting the relevant items and calculated total revenue from those qualified invoices for a merchant.
- This was our first attempt at consuming an API before learning about rails conventions and best practices, so figuring out how to implement the Unplash API proved extremely time consuiming. However, working together as a group, we were able to successfully display images on all webpages throughout the application. 
  
### Accomplishments:
- Advanced ActiveRecord Queries: I gained a deeper understanding of using ActiveRecord queries to retrieve and manipulate data from the database efficiently. This included complex joins, aggregations, and calculations to obtain the required information for various features and statistics. Additionally, I assisted other group members in creating queries they needed on other parts of the application.
- Managing Application State with Enums: I learned how to use Rails enums effectively to manage various statuses within the application, such as the status of invoices, items, and merchants. Enums allowed for clearer and more readable code when dealing with multiple status options.
- API Integration: One of the significant learnings from creating "Little Esty Shop" was how to integrate with external APIs, like the Unsplash API, to fetch and display dynamic content, such as images, for a more interactive user experience.

### Other Contributors to this Project:
[Anna Wiley](https://github.com/awiley33)</br>
[Dani Rae Wilson](https://github.com/dani-wilson)</br>
[Matthew Lim](https://github.com/MatthewTLim)</br>
[Mike Wood](https://github.com/MWoodshop)</br>

### Ideas for Potential Refactor:
- Making a single, cohesive test-data block that could be used across the testing suite
- Adding more sad path testing and exploring more edge cases
- More consistent styling across all page views
- Agreeing upon convention to do with 'describe' and 'it' blocks in rspec testing
- Making ActiveRecord queries more compact wherever possible
---
### Setup:
To explore the Little Esty Shop project on your local machine, follow these steps:

1. **Clone the Repository:** Open your terminal and navigate to the directory where you want to store the project. Then, run the following command to clone the repository:
`git clone git@github.com:westonio/little-esty-shop.git`
2. **Install Dependencies:** Move into the project's directory and install the required gems by running:
`cd little-esty-shop`
`bundle install`
3. **Database Setup:** Create and set up the database. Run the following commands to drop, create, migrate, and seed the database:
`rails db:{drop,create,migrate,seed}`
> This will populate your database with initial data.

4. **Start the Server:** Start the Rails server by running the following command:
`rails server`
5. **Access the Project:** Open your web browser and navigate to http://localhost:3000. This will take you to the Little Esty Shop project, where you can explore its features and functionalities.
> Remember that you can stop the server at any time by pressing Ctrl + C in your terminal.

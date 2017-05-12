# Honeycomb Engineering Test - Makers Edition

## The challenge

### What we want from you

Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.

We don't need any UI for this, we just need you to show us how it would work through its API.

### Design Improvements
Based on the assumption that the conditions of discounts will change a lot, I've created a new discount class which can be instantiated with a hash of various values or has defaults. I chose a hash as there is no confusion with the order in which you pass arguments, and you can simply pass in a specific (e.g. price_point => 20) and let the rest go to defaults.
I wanted the classes to know as little about each other as possible, thus Order never directly references discount; all it knows it that it is sometimes passed an object which responds to final_price, msg and error_msg. Order merely understands to display information, it does not know how or why a given discount is applied.
Given how different each discount could be this seems like the minimal viable amount of information to pass between classes, an order may want to display information such as 'Student Discount' or similar, or a custom error message. As it's important for conditions to be changeable, orders can add or remove a discount after they have been created.
I also chose a method call for the discount variable in; although it makes no difference at this level it's more updatable than a direct variable call (@discount) as you could add more to the method at a later point.
Discount knows nothing about the order, it is just passed conditions and returns an updated value based on these. You could have a variety of discounts objects in play; Students, Veterans and so on and simply pass these to your various Order objects as and when you see fit.
The main things kept in mind during this were single responsibility principle, DRY, dependency injections, and generally keeping the cost of further change to a minimum.

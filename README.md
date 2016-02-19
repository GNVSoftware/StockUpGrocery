StockUp is a grocery carpooling application for college students only. 
Team: Franky Liang, Zhan Liang, Pranav Achanta
User Stories:
[] - Users should be able to see people offering rides to the user's present location
[] - Settings page with filters
[] - Ability to chat with each other
[] - Allow people offering rides to accept or decline a request
[] - User authentication - for now @ufl.edu
[] - User ratings - Driver and Rider

Optionals:
[] - Map view
[] - Real time driver location
[] - User and driver details
[] - Location of grocery store
[] - Store ratings, link to BOGO deals

User - userid, email, password, rides, requests, rating
Rides - rideid, requests, spots left, lock status, time, price, destination
Requests - requestid, messages, requestrname, requestaddress, riderid, driverid
Message - requestid, rideid
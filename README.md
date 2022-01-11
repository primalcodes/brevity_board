# README

This application is designed as a bare bones example of a message board.
Keeping the application basic as most POCs are destined to take on a flurry of
changes/requests as decision makers uncover new requirements.  As I pulled together my approach to building out the app in short order, I kept rough notes of how I wanted to execute the implementation (see dev_notes.txt).  The notes and order of operation helped to maximize what the framework and gems could offer.


I leveraged [HTMX](https://htmx.org) for simple implementation of ajax requests to pull in forms for modals as well as lazy loading comments into the posts#show view.  This helps to keep UI decisions non-committal during the initial development phases of the application.

Pagination started out leveraging the [pagy](https://github.com/ddnexus/pagy) gem, but later determined that I wanted to demonstrate that implementing basic paging (much like authentication with devise) is simple enough to do on our own, eliminating a gem dependency.

Finally, leveraging the faker gem and seeds.rb, I filled out the database with sample info.

## Setup Notes:
* Ruby version: 3.0.0
* Rails version: 6.1.4.4
* Database creation/initialization
`rails db:setup`

* How to run the test suite
`rspec`

* Deployment done through Heroku web interface


#= require ./lib/showdown
#= require ./lib/moment
#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self

App.Store = DS.Store.extend(
  revision: 12
  adapter: "DS.RESTAdapter" # "DS.FixtureAdapter"
)

App.Biblebook = DS.Model.extend(
  title: DS.attr("string")
  author: DS.attr("string")
  intro: DS.attr("string")
  extended: DS.attr("string")
  publishedAt: DS.attr("date")
)

# biblebooks = [
#   id: "1"
#   title: "Rails is Omakase"
#   author:
#     name: "d2h"

#   date: new Date("12-27-2012")
#   excerpt: "There are lots of à la carte software environments in this world. Places where in order to eat, you must first carefully look over the menu of options to order exactly what you want."
#   body: "I want this for my ORM, I want that for my template language, and let's finish it off with this routing library. Of course, you're going to have to know what you want, and you'll rarely have your horizon expanded if you always order the same thing, but there it is. It's a very popular way of consuming software.\n\nRails is not that. Rails is omakase."
# ,
#   id: "2"
#   title: "The Parley Letter"
#   author:
#     name: "d2h"

#   date: new Date("12-24-2012")
#   excerpt: "My [appearance on the Ruby Rogues podcast](http://rubyrogues.com/056-rr-david-heinemeier-hansson/) recently came up for discussion again on the private Parley mailing list."
#   body: "A long list of topics were raised and I took a time to ramble at large about all of them at once. Apologies for not taking the time to be more succinct, but at least each topic has a header so you can skip stuff you don't care about.\n\n### Maintainability\n\nIt's simply not true to say that I don't care about maintainability. I still work on the oldest Rails app in the world."
# ]
App.Router.map ->
  @resource "about"
  @resource "biblebooks", ->
    @resource "biblebook", { path: ":biblebook_id" }
    # @route "new"

# App.BiblebooksRoute = Ember.Route.extend(model: ->
#   biblebooks
# )
App.BiblebooksRoute = Ember.Route.extend
  model: ->
    App.Biblebook.find()

# App.BiblebookRoute = Ember.Route.extend(model: (params) ->
#   biblebooks.findBy "id", params.biblebook_id
# )

# App.BiblebooksNewRoute = Ember.Route.extend(
#   model: ->
#     App.Biblebook.createRecord(publishedAt: new Date(), author: "current user")
# )

# See Discussion at http://stackoverflow.com/questions/14705124/creating-a-record-with-ember-js-ember-data-rails-and-handling-list-of-record
App.BiblebooksController = Ember.ArrayController.extend(
  sortProperties: [ "id" ]
  sortAscending: false
  filteredContent: (->
    content = @get("arrangedContent")
    content.filter (item, index) ->
      not (item.get("isNew"))
  ).property("arrangedContent.@each")
)
App.BiblebookController = Ember.ObjectController.extend(
  isEditing: false
  edit: ->
    @set "isEditing", true

  delete: ->
    if (window.confirm("Are you sure you want to delete this biblebook?"))
      @get('content').deleteRecord()
      @get('store').commit()
      @transitionToRoute('biblebooks')

  doneEditing: ->
    @set "isEditing", false
    @get('store').commit()

)
App.BiblebooksNewController = Ember.ObjectController.extend(
  save: ->
    @get('store').commit()

  cancel: ->
    @get('content').deleteRecord()
    @get('store').transaction().rollback()
    @transitionToRoute('biblebooks')

  transitionAfterSave: ( ->
    # when creating new records, it's necessary to wait for the record to be assigned
    # an id before we can transition to its route (which depends on its id)
    @transitionToRoute('biblebook', @get('content')) if @get('content.id')
  ).observes('content.id')
)
showdown = new Showdown.converter()
Ember.Handlebars.helper "format-markdown", (input) ->
  new Handlebars.SafeString(showdown.makeHtml(input))

Ember.Handlebars.helper "format-date", (date) ->
  moment(date).fromNow()

# App.IndexRoute = Ember.Route.extend(redirect: ->
#   @transitionTo "biblebooks"
# )




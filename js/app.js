App = Ember.Application.create();

App.Router.map(function() {
  this.resource('about');
  this.resource('biblebooks', function() {
    this.resource('biblebook', { path: ':biblebook_id' });
  });
});

App.BiblebooksRoute = Ember.Route.extend({
  model: function() {
    return biblebooks;
  }
});

App.BiblebookRoute = Ember.Route.extend({
  model: function(params) {
    return biblebooks.findBy('id', params.biblebook_id);
  }
});

App.BiblebookController = Ember.ObjectController.extend({
  actions: {
    isEditing: false,

    edit: function() {
      this.set('isEditing', true);
    },

    doneEditing: function() {
      this.set('isEditing', false);
      this.get('store').commit();
    }
  }
});

var biblebooks = [{
  id: '1',
  title: "Rails is Omakase",
  author: { name: "d2h" },
  date: new Date('12-27-2012'),
  excerpt: "There are lots of à la carte software environments in this world. Places where in order to eat, you must first carefully look over the menu of options to order exactly what you want.",
  body: "I want this for my ORM, I want that for my template language, and let's finish it off with this routing library. Of course, you're going to have to know what you want, and you'll rarely have your horizon expanded if you always order the same thing, but there it is. It's a very popular way of consuming software.\n\nRails is not that. Rails is omakase."
}, {
  id: '2',
  title: "The Parley Letter",
  author: { name: "d2h" },
  date: new Date('12-24-2012'),
  excerpt: "My [appearance on the Ruby Rogues podcast](http://rubyrogues.com/056-rr-david-heinemeier-hansson/) recently came up for discussion again on the private Parley mailing list.",
  body: "A long list of topics were raised and I took a time to ramble at large about all of them at once. Apologies for not taking the time to be more succinct, but at least each topic has a header so you can skip stuff you don't care about.\n\n### Maintainability\n\nIt's simply not true to say that I don't care about maintainability. I still work on the oldest Rails app in the world."
}];

// var client = algoliasearch("4J2JTO3FLK", "2f4cff0198aca3ee49fffa6df138e260")
// var meals = client.initIndex('meals');
// var categories = client.initIndex('categories');

// autocomplete('#aa-search-input', {}, [
//     {
//       source: autocomplete.sources.hits(meals, { hitsPerPage: 5 }),
//       displayKey: 'name',
//       templates: {
//         header: '<div class="aa-suggestions-category">Meals</div>',
//         suggestion: function(suggestion) {
//           return '<span>' +
//             suggestion._highlightResult.name.value + '</span><span>'
//               + suggestion._highlightResult.category.value + '</span>';
//         }
//       }
//     },
//     {
//       source: autocomplete.sources.hits(categories, { hitsPerPage: 3 }),
//       displayKey: 'name',
//       templates: {
//         header: '<div class="aa-suggestions-category">Teams</div>',
//         suggestion: function(suggestion) {
//           return '<span>' +
//             suggestion._highlightResult.name.value + '</span><span>'
//               + suggestion._highlightResult.location.value + '</span>';
//         }
//       }
//     }
// ]);
